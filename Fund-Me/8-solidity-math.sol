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
    // to allow this function to receive native crypto we have to add the 'payable' keyword to the function before the curly braces
    // by now running the fund function on a testnet we can fund this contract account with eth provided the requirements in the function are met
    function fund() public payable {
        // this function allows users to send $
        // and have a minimum of 5$ sent

        // the statement below requires that the minimum value be sent is >= 5 usd
        // because the 'msg.value' uses ETH to evaluate expressions we need a way to convert the 5 usd value to a value that works with msg.value

        // To do this we use an Oracle

        // we can now use the 'getConversionRate' function from below over here to get the amount of eth sent in usd
        // but because 'getConversionRate' needs an input with 18 zeroes (decimal places) we need to raise the minimum usd variable by 18 places
        require(getConversionRate(msg.value) >= minimumUsd,"didn't send enough ETH");
        // if we run this contract by setting a value of more than 5 usd of eth in the 'value' tab on remix this tx will go thru
        // however if the value is less than 5 usd we will get an error 
    }

    // we will proceed to create a function to get the current price of eth in usd below
    function getPrice() public view returns(uint256){
        
        // To actually get the price we will create a new variable that uses the address and ABI to fetch the data
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        // and then call a method to fetch the price
        // This method returns multiple items,but we only want the price,so we'll only include that
        (,int256 price,,,)= pricefeed.latestRoundData();
        // The code will return the price of ETH in USD that looks like this 200000000000 which is supposed to be to 8 demicals

        // we have used typecasting below to convert the value returned since the 'msg.value' method returns a value with 18 decimal places...
        // as opposed to price which will return 8 decimal places
        return uint256(price * 1e10);

        

    }

    // we will also create another function to perform the conversion between usd and eth
    // the function below will take an eth value and convert it to dollars
    function getConversionRate(uint256 ethvalue) public view returns(uint256) {
        
        // we will call the 'getPrice' function above to get the price of eth
        // remember this function returns the Eth price with 18 decimal places
        uint256 ethprice = getPrice();

        // we will then multiply the ethvalue input for this function with the output of the 'getPrice' function
        // we divide the result by 18 because each of the outputs has 18 decimal places which will produce an output of 36 decimal places when divided
        uint256 ethAmountInUSD = (ethvalue * ethprice)/1e18;
        // An important rule in solidity is you want to multiply before you divide since only whole numbers work in solidity

        return ethAmountInUSD;
        // we can now use this function to convert the eth amount we get main 'fund' function above
    }

    // a function that the owner of the contract is going to use to withdraw money
    // function withdraw() public {}
}


