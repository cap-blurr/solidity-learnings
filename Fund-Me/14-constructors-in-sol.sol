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

    // A problem with using the current 'withdraw' function is that anyone can call that function and withdraw the funds
    // we obviously only want the owner of the contract to be able to do this and to accomplish this we can use a 'constructor'
    // constructors are the first functions that are immediately called after you deploy a contract

    // we'll create a variable of type address to denote the owner of the contract
    address public owner;

    constructor() {
        // we'll then set the address of the owner to be msg.sender which since the constructor is called when the contract is initialized ...
        // ... will be the address that initializes the contract or the owner of the contract
        owner = msg.sender;
    }

    function fund() public payable {

        require(msg.value.getConversionRate() >= minimumUsd,"didn't send enough ETH");
        
        funders.push(msg.sender);

        /*another hack you can do below is replace the '+ msg.value' to '+= msg.value' like so below*/
        AddressToAmountFunded[msg.sender] += msg.value;
        
    }
    
    // awesome now since we can use the 'fund' function above to fund the contract,we can now proceed and create a withdraw function to withdraw the funds

    function withdraw() public {
        // Now to modify the withdraw function so that only the owner can call this function like so
        require(msg.sender == owner,"must be owner!");
        // The code above basically says that the address that is going to send funds has to be equal to the owner of the contract...
        // .. who we've set in the constructor above

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
}


