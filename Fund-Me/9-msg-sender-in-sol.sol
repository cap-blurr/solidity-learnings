// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// a good habit before starting to write code is to write the list of steps you need to do

// we need to get funds from users
// withdraw funds
// set a minimum funding value in USD in this case 5$

// Now instead of copy pasting the interface code from github,we can just import it using named imports the same way we import other contracts in solidity

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
// The import above is the same as just copy pasting the interface code


contract FundMe {
    // a function to send money to our contract

    // raising this value by 18 places
    uint256 public minimumUsd = 5e18;

    // the next thing we should is create an array to keep track of all the users that send us money
    // so we create an array of type 'address'
    address[] public funders;

    // we can also go ahead and create a mapping of the address to see how much each user has sent
    mapping(address => uint256) public AddressToAmountFunded;


    // by now running the fund function on a testnet we can fund this contract account with eth provided the requirements in the function are met
    function fund() public payable {
        // this function allows users to send $

        // the statement below requires that the minimum value be sent is >= 5 usd
        // To do this we use an Oracle

       
        require(getConversionRate(msg.value) >= minimumUsd,"didn't send enough ETH");

        // we can then use 'msg.sender' to get the address of the user that sent funds and push that address to the funders array we created above
        // msg.sender is another global variable we can use in solidity which refers to whoever calls this function
        funders.push(msg.sender);

        // now if someone funds the contract we can now get the funders address and add the amount to whatever they previously funded with what they are now adding
        AddressToAmountFunded[msg.sender] = AddressToAmountFunded[msg.sender] + msg.value;
        
    }

    // we will proceed to create a function to get the current price of eth in usd below
    function getPrice() public view returns(uint256){
        
        
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        
        // This method returns multiple items,but we only want the price,so we'll only include that
        (,int256 price,,,)= pricefeed.latestRoundData();
        
        return uint256(price * 1e10);
    }


    // the function below will take an eth value and convert it to dollars
    function getConversionRate(uint256 ethvalue) public view returns(uint256) {
        
        // we will call the 'getPrice' function above to get the price of eth
        uint256 ethprice = getPrice();

        // we will then multiply the ethvalue input for this function with the output of the 'getPrice' function
        uint256 ethAmountInUSD = (ethvalue * ethprice)/1e18;
        // An important rule in solidity is you want to multiply before you divide since only whole numbers work in solidity

        return ethAmountInUSD;
        // we can now use this function to convert the eth amount we get main 'fund' function above
    }

    // a function that the owner of the contract is going to use to withdraw money
    // function withdraw() public {}
}


