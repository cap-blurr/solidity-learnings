// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// a good habit before starting to write code is to write the list of steps you need to do

// we need to get funds from users
// withdraw funds
// set a minimum funding value in USD

contract FundMe {
    // a function to send money to our contract

    // to allow this function to receive native crypto we have to add the 'payable' keyword to the function before the curly braces
    function fund() public payable {
        // this function allows users to send $
        // and have a minimum $ sent

        // to access the value amount of a txn in solidity we use the 'msg.value' global function
        // if we want to direct that users have to spend >1 ETH we can use the 'require()' keyword
        require(msg.value > 1e18, "didn't send enough ETH");
        // 1e18 is equivalent to 1ETH in wei
        // we can also add a little revert message in string form

        // if you run this function the tx will revert if you send anything below 1ETH but will work if you increase the value to > 1eth
    }

    // a function that the owner of the contract is going to use to withdraw money
    // function withdraw() public {}
}


