// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; //This is the solidity compiler version

contract Simplestorage {
    // functions or methods are a subsection of code that when called will execute a specific small piece of our codebase
    uint256 myfavoritenumber; //we've had to rename this variable since the new favoritenumber variable is in the same scope as it

    //In solidity we can create our own types using the 'Struct' command

    struct person{
        uint256 favoritenumber;
        string name;
    }


    // we can create a variable of type 'person' above same way we created a variable of type myfavoritenumber above   
    person public rat = person({favoritenumber:9,name:"rat"});
    
    // we can create an array/list of persons like below
    person[] public listofpeople;


    // mappings are equivalent to dictionaries in python
    // to create a mapping you do as follows
    mapping(string => uint256) public nametofavoritenumber;
    // the mapping above is signifying a mapping of strings to numbers(mapping a persons name to their favorite number)
    // we have created the variable nametofavoritenumber for it


    // below is a function that updates our favoritenumber variable above
    function store(uint256 _favoritenumber) public {
        myfavoritenumber = _favoritenumber;
    }
   
    // below is a similar function similar to the public keyword used in 'uint256 favoritenumber' variable. this is a getter function
    function retrieve() public view returns(uint256) {
        return myfavoritenumber;
    }

    // we'll create a function below to add people to our listofpeople dynamic array above
    // the function will take 2 arguments,the same ones located in the custom person type

    function addpeople(string memory _name,uint256 _favoritenumber) public {
        listofpeople.push(person(_favoritenumber,_name));

        //we have the array above adding people to our list of people,we can create a new method to add people to our mapping
        // so instead of having to loop throught each value in an array we can just look up someone's favorite number using their name
        nametofavoritenumber[_name] = _favoritenumber;
        // the variable in the bracket represents the key of the mapping and the variable after the = sign represents the value
        // now we can look up peoples favorite numbers using their names
        // in mappings the default value for all keys is zero,means if a key isnt specified it will return the default value when queried
        
        
    }

    
}

