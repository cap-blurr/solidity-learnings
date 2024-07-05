// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// say we want to add some functionality to the methods in the simplestorage contract for example we want to add 5 whenever the store method is called
// we can do that using inheritance

// first we will import the simplestorage contract
import {SimpleStorage} from "./SimpleStorage.sol";

// we can add all the functionality found in the simple storage contract using the "is" syntax below
// now the AddFiveStorage contract will inherit everything found in the simplestorage contract
contract AddFiveStorage is SimpleStorage{
    // when you deploy this contract you will find that you are able to use all the methods found in the SimpleStorage contract
    // now we can add our own custom functionality into AddFiveStorage that isnt in the simplestorage contract like below

    function sayHello() public pure returns(string memory) {
        return "Hello";
    }

    // now to change the store function in thes simple storage contract so that 5 is added to the favoritenumber variable
    // to do this we will do something called "overrides"

    // there are 2 keywords to be aware of when doing overrides which are "virtual" and "override"
    // this tells solidity that we want to override the original function in the simplestorage contract with this new function
    // to do this we will add the keyword "override" just before the curly braces for the function like below

    function store(uint256 _newNumber) public override {
        // inorder for this to work you also need to add the "virtual" keyword to the original function in the simplestorage contract

        // since we have access to everything in the SimpleStorage contract we can now add five by simply calling the favoritenumber variable in the simple storage contract

        myfavoritenumber = _newNumber + 5;
    }                           
}