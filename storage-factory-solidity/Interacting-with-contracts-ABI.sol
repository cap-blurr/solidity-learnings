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


    // to track the addresses where the contract is deployed to we'll change the simplestorage variable to an array and the name to listofSimpleStorageContracts
    SimpleStorage[] public ListofSimpleStorageContracts;


    // This function is a function that creates another contract in solidity.
    function CreateSimpleStorageContract() public {

        // we'll call the state variable as such
        SimpleStorage newSimpleStorageContracts=  new SimpleStorage();

        // the problem is that we need to keep track of all the addresses where the created contract is at
        // to ease this we can now push the addresses created for each newly created contract in this funtion and query what the address is using the array's index
        ListofSimpleStorageContracts.push(newSimpleStorageContracts);
    }

    // next step is now to interact with other contracts from this contract
    // As of now we can think of our StorageFactory contract as a manager for all the contracts we deploy in it
    // We will now call the functions of the contracts that we have deployed by writing a function to do this
    // The function will take in 2 arguments
    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        // To interact with a contract,you're gonna need 2 things, The address of the contract and the ABI which is the Applicating Binary Interface
        // The ABI will tell our code exactly how it can interact with our contract
        // The compiler automatically knows what the ABI is

        // so below lets get a simplestorage contract to interact with our list of contracts array
        // this basically takes the index of the array as input and fetches the address at that index
        SimpleStorage mySimpleStorage = ListofSimpleStorageContracts[_simpleStorageIndex];

        // then we can use the new variable created above to call any function in that contract as such
        mySimpleStorage.store(_newSimpleStorageNumber);

        // the above is cool,but we can't read the new number saved to the mySimpleStorage variable yet

    }
    // so below we create a function to read from our simple storage contract as well
    function sfGet(uint256 _SimpleStorageIndex) public view returns(uint256) {
        SimpleStorage mySimpleStorage = ListofSimpleStorageContracts[_SimpleStorageIndex];

        // we are now calling the retrieve method in the SimpleStorage contract
        return mySimpleStorage.retrieve();


        // we can also condense the lines of code above to this
        return ListofSimpleStorageContracts[_SimpleStorageIndex].retrieve();

    }
}