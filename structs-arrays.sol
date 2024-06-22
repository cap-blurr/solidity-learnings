// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; //This is the solidity compiler version

contract Simplestorage {
    // functions or methods are a subsection of code that when called will execute a specific small piece of our codebase
    uint256 myfavoritenumber; //we've had to rename this variable since the new favoritenumber variable is in the same scope as it



    // what if we want to store a list of favorite numbers?, we can create a list by adding '[]' after the type e.g
    uint256[] listoffavoritenumbers; //[0,4,5,6]



    //how do we know whose favorite number is?, instead of a raw list like above we can create our own type
    //In solidity we can create our own types using the 'Struct' command

    struct person{
        uint256 favoritenumber;
        string name;
    }

    // we can create a variable of type 'person' above same way we created a variable of type myfavoritenumber above

    // as seen below this is a type of person with visibility public
    // when defining a custom type variable you have to call it at the left and the right side and then parse in the arguments accepted by that custom type
    person public cat = person(7,"Cat"); 
    
    
    // you can add curly brackets inside the parenthesis to be more specific when assigning the arguments e.g
    person public rat = person({favoritenumber:9,name:"rat"});


    // but what if we have a lot of people to assign to that struct?
    // we can create an array/list of persons like below
    // to access the elements of the custom struct array you use the index number
    // the array below is known as a dynamic array,because there is nothing in the square brackets
    // if you add a number in the square brackets e.g 'person[3]' the array becomes a static array since you can only put the number of items specified in the brackets
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
        // to add people to the dynamic array we will use the push method which comes with arrays and allows you to push elements to the array
        // the code below will run the 'person()' array first and then the push method after and this will add new people with their name and number to the array
        // once added you can go and select the list of people using the array index
        listofpeople.push(person(_favoritenumber,_name));
    }

}
