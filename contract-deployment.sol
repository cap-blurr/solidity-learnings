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


    // to create a mapping you do as follows
    mapping(string => uint256) public nametofavoritenumber;
    

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

       
        nametofavoritenumber[_name] = _favoritenumber;
       
        // dont ever deploy a smart contract without running tests or auditing it since you cant update a contract once deployed
    }

    // to first deploy your contract to a testnet,you need to change the encvironment to 'Injected Provider' and select which wallet provider you are using
    // you should then just click deploy on remix and sign the associated transaction involved for doing this
    // after deploying we can notice that using the view or pure functions doesnt trigger a txn signing message from metamask since we arent updating the blockchain
    // but if we use methods that update the chain,we will be made to sign txns
    
    
}

