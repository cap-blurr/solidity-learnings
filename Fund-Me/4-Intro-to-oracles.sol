// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// a good habit before starting to write code is to write the list of steps you need to do

// we need to get funds from users
// withdraw funds
// set a minimum funding value in USD in this case 5$

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
        // An oracle is any device that interacts with off chain world to provide external data or computation to smart contracts

        // we use chainlink which is a decentralised oracle network that can be customized to bring any real world data to smart contracts
        // chainlink comes with out of the box solutions to allow you to plug and play real world data to your application like using 'chainlink data feeds'

        // the 'data feeds' work by aggregating data from various data providers and exchanges and parses that data through a network of chainlink nodes...
        // .... the chainlink nodes use a median to determine what the actual price of an asset is and delivers that in a single tx to a reference contract on chain....
        // .... that other smart contracts can use
        require(msg.value >= minimumUsd, "didn't send enough ETH");

        
    }

    // a function that the owner of the contract is going to use to withdraw money
    // function withdraw() public {}
}


