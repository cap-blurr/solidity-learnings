// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; //This is the solidity compiler version

contract Simplestorage {
    // functions or methods are a subsection of code that when called will execute a specific small piece of our codebase
    uint256 myfavoritenumber; //we've had to rename this variable since the new favoritenumber variable is in the same scope as it


    // what if we want to store a list of favorite numbers?, we can create a list by adding '[]' after the type e.g
    uint256[] listoffavoritenumbers; //[0,4,5,6]


    //In solidity we can create our own types using the 'Struct' command

    struct person{
        uint256 favoritenumber;
        string name;
    }


    // we can create a variable of type 'person' above same way we created a variable of type myfavoritenumber above   
    person public rat = person({favoritenumber:9,name:"rat"});


    
    // we can create an array/list of persons like below
    person[] public listofpeople;



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
        
        // there are 6 places you can store data in solidity which are stack,memory,storage,calldata,code and logs
        // memory and calldata means that the variable that comes after them will only exist temporarily,it will only exist for the duration of the function call
        // you have to specify what store data method you'll use for strings and by default all function variables inside functions default to memory variables
        // the difference between 'memory' and 'calldata' is memory variables can be changed or manipulated while 'calldata' cannot be changed
        // memory is temporary variables that CAN be modified,calldata is temporary variables that CAN'T be modified and storage is permanent variables that CAN be modified
        // if you create a variable OUTSIDE A FUNCTION it will automatically be a 'storage' variable

        // you have to indicate what store data type you will use for strings specifically since underneath the hood strings is an array of bytes and in solidity you need to define what store data method you will use for arrays
        // so structs,mappings and arrays need to have the 'memory' keyword before being used
    }


    // warnings will not prevent you from compiling or deploying your code, but it is important to correct all warnings before deploying
    // errors will prevent you from compiling and deploying your code
}

