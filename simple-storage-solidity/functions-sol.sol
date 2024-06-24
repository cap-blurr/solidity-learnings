// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; //This is the solidity compiler version

contract Simplestorage {
    // functions or methods are a subsection of code that when called will execute a specific small piece of our codebase
    uint256 public favoritenumber;
    // adding public after the type changes the visibility of the variable which is set to 'internal' by default

    // below is a function that updates our favoritenumber variable above
    function store(uint256 _favoritenumber) public {
        favoritenumber = _favoritenumber;

        // functions can have 4 different visibility specifiers which are public,private, internal and external
    }
   // every single contract has a unique public address similar to wallets

    // below is a similar function similar to the public keyword used in 'uint256 favoritenumber' variable. this is a getter function
    function retrieve() public view returns(uint256) {
        return favoritenumber;
        // the view keyword basically just reads the state from the blockchain but doesnt actually send a transaction
        // e.g in the function above we are just reading what the 'favoritenumber' variable is
    // the 'view' keyword above disallows any modification of state

    //'pure' keywords disallow modifying/updating state and also reading from state or storage

        // the 'store' function above isnt reading,its updating the blockchain so you need to send a tx to do that
    }

    // the 'view' and 'pure' keywords can be used without spending any gas since you are not sending a tx to the chain
}
