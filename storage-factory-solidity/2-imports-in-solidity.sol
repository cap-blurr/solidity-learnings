// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// we can use the 'import' keyword to import other files to our current file like so

import "./SimpleStorage.sol";
// when importing files you should make sure to use compatible versions of solidity at the top
// The import described above is ok but quite basic,theres a better way of importing called 'named imports'

// There is a way to import only a specific contract or specific part of a contract in solidity using named imports as seen below
import {SimpleStorage} from "./SimpleStorage.sol";
// you can include in the curly braces only the specific contract or contracts you want to import from a file

contract StorageFactory{

    // we'll save the contract to be deployed as a state or solid variable
    SimpleStorage public simplestorage;


    // This function is a function that creates another contract in solidity.
    // This feature is called composability,which is where smart contracts interact with one another which allows us to build ever more complicated financial products
    function CreateSimpleStorageContract() public {

        // we'll call the state variable as such
        simplestorage =  new SimpleStorage();
        // the 'new' keyword is how solidity knows to deploy a contract
    }

}