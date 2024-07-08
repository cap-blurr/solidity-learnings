// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
// This is a new file that is a library
// In solidity you can create your own library using the 'library' keyword

// Libraries are similar to contracts, but you can't declare any state variable and you can't send ether

// A library is embedded into the contract if all library functions are internal.
// Otherwise the library must be deployed and then linked before the contract is deployed.

// below we'll create a library that does price conversions between eth and usd which is currently a function in the main Fundme contract

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{

    // so below we have copypasted the 'getprice'and 'getConvertionRate' functions from the Fundme contract
    // we are instead putting them inside this library and then change the visibility to internal
    function getPrice() internal view returns(uint256){
        
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        
        (,int256 price,,,)= pricefeed.latestRoundData();
        return uint256(price * 1e10);
    }


    // the function below will take an eth value and convert it to dollars
    function getConversionRate(uint256 ethvalue) internal view returns(uint256) {
        
        uint256 ethprice = getPrice();
        uint256 ethAmountInUSD = (ethvalue * ethprice)/1e18;
        return ethAmountInUSD;
        
    }
    // we can now proceed to import this library in the Fundme contract and use its functions from there
}