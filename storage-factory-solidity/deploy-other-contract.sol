// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// weve copy pasted the simple storage contract below in order to call it from the storage factory contract
contract SimpleStorage {
    uint256 myfavoritenumber; 

    struct person{
        uint256 favoritenumber;
        string name;
    }

    person public rat = person({favoritenumber:9,name:"rat"});

    person[] public listofpeople;

    mapping(string => uint256) public nametofavoritenumber;
    
    function store(uint256 _favoritenumber) public {
        myfavoritenumber = _favoritenumber;
    }
   
    function retrieve() public view returns(uint256) {
        return myfavoritenumber;
    }

    function addpeople(string memory _name,uint256 _favoritenumber) public {
        listofpeople.push(person(_favoritenumber,_name));
        nametofavoritenumber[_name] = _favoritenumber;
    }
   
}


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