// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// a good habit before starting to write code is to write the list of steps you need to do

// we need to get funds from users
// withdraw funds
// set a minimum funding value in USD

contract FundMe {
    // a function to send money to our contract

    uint256 public myvalue = 1;
    // to allow this function to receive native crypto we have to add the 'payable' keyword to the function before the curly braces
    function fund() public payable {
        // this function allows users to send $
        // and have a minimum $ sent

        // to access the value amount of a txn in solidity we use the 'msg.value' global function
        myvalue = myvalue + 2;
        require(msg.value > 1e18, "didn't send enough ETH");

        // next we're doing reverts
        // a revert is a function that undos any actions that have been done,and sends the remaining gas back
        // in the example above,if the require statement is reached and it evaluates unsucessfully the code will revert which will mean that the line above will not be executed...
        // ....or the tx will not go through. 

        // So if a tx reverts it undoes all the code that came before it
        // this is a problem because a failed tx like this will consume gas
        
    }

    // a function that the owner of the contract is going to use to withdraw money
    // function withdraw() public {}
}


