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


    function fund() public payable {
        // now to use the function for getting the conversion rate we can do
        msg.value.getConversionRate();
        // another thing to note is that with a Library the first input variable...
        // will be the type that you are using for your library,in our case this is uint256
        
        // and now to get the conversion rate we can do
        require(msg.value.getConversionRate() >= minimumUsd,"didn't send enough ETH");
        // and if you compile,this will compile succesfully
        funders.push(msg.sender);
        AddressToAmountFunded[msg.sender] = AddressToAmountFunded[msg.sender] + msg.value;
        // notice that we dont parse any value in the parenthesis,this is because of setting the type at the beginning in the contract,so the value that gets...
        // ...called with the function is automatically parsed thru
        
        // if we had a second argument in the function tho,that would be the first value to be parsed in
    }
    
    // a function that the owner of the contract is going to use to withdraw money
    // function withdraw() public {}
}


