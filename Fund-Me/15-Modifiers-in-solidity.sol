// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// a good habit before starting to write code is to write the list of steps you need to do

// we need to get funds from users
// withdraw funds
// set a minimum funding value in USD in this case 5$

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    

    // now we can attach the functions in our PriceConverter Library to all 'uint256' we can do the following
    using PriceConverter for uint256;

    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping(address => uint256) public AddressToAmountFunded;

    // we'll create a variable of type address to denote the owner of the contract
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {

        require(msg.value.getConversionRate() >= minimumUsd,"didn't send enough ETH");
        
        funders.push(msg.sender);

        /*another hack you can do below is replace the '+ msg.value' to '+= msg.value' like so below*/
        AddressToAmountFunded[msg.sender] += msg.value;
        
    }
    
    // awesome now since we can use the 'fund' function above to fund the contract,we can now proceed and create a withdraw function to withdraw the funds

    // Now instead of having to use the require statement in the function we can use the modifier instead
    function withdraw() public onlyOwner {
        

        // for loop option for resetting array
        for (uint256 FunderIndex = 0; FunderIndex < funders.length; FunderIndex = FunderIndex + 1 /* or you can also use ++ instead of + 1 which is the same thing*/) {
            // the code below is setting the funder variable to the current index of the funders array in the loop
            address funder = funders[FunderIndex];
            AddressToAmountFunded[funder] = 0;
            }
        
        
        // reset array options
        funders = new address[](0);

        // actually withdrawing the funds
        // There are 3 different ways of sending eth from a contract which are
        // - transfer
        // - send 
        // - call

        /*For now we'll use the call method from what we learned earlier*/
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess,"Call failed");
    }

    // Lets say we have a lot of functions that should only be called by the owner,we'd have to put the require line on each one of them
    // Enter modifiers
    // Modifiers are going to allow us to create a keyword that we can put right in the function declaration to add some functionality very easily and quickly to any function
    // To setup a modifier is the same as setting up a function but without using visibility specifiers
    modifier onlyOwner() {
        require(msg.sender == owner,"sender is not owner!");
        _;
        // The underscore basically tells solidity proceed to do whatever else is in the function after executing ...
        // ... the line above first

        // the position of the underscore matters because if it was placed before the statement,then the code in ...
        //... the function would run first then whatever is in the modifier last
    }
}


