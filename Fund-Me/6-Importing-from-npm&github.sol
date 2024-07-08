// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// a good habit before starting to write code is to write the list of steps you need to do

// we need to get funds from users
// withdraw funds
// set a minimum funding value in USD in this case 5$

// Now instead of copy pasting the interface code from github,we can just import it using named imports the same way we import other contracts in solidity

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
// The import above is the same as just copy pasting the interface code


contract FundMe {
    // a function to send money to our contract

    uint256 public minimumUsd = 5;
    // to allow this function to receive native crypto we have to add the 'payable' keyword to the function before the curly braces
    function fund() public payable {
        // this function allows users to send $
        // and have a minimum of 5$ sent

        // the statement below requires that the minimum value be sent is >= 5 usd
        // because the 'msg.value' uses ETH to evaluate expressions we need a way to convert the 5 usd value to a value that works with msg.value

        // To do this we use an Oracle

        require(msg.value >= minimumUsd, "didn't send enough ETH");
        
    }

    // we will proceed to create a function to get the current price of eth in usd below
    function getPrice() public{
        
        // AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).description();
        

    }

    // we will also create another function to perform the conversion between usd and eth
    function getConversionRate() public{}


    // the function below is created specifically to showcase how to call a method from the interface contract above
    function getDescription() public view returns (string memory) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).description();
    }


    // a function that the owner of the contract is going to use to withdraw money
    // function withdraw() public {}
}


