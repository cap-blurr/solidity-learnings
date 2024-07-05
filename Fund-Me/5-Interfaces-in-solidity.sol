// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// a good habit before starting to write code is to write the list of steps you need to do

// we need to get funds from users
// withdraw funds
// set a minimum funding value in USD in this case 5$

// below is the copypasted interface code for getting the price data copied from chainlink github
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(
    uint80 _roundId
  ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}

contract FundMe {
    // a function to send money to our contract

    uint256 public minimumUsd = 5;
    // to allow this function to receive native crypto we have to add the 'payable' keyword to the function before the curly braces
    function fund() public payable {
        // this function allows users to send $
        // and have a minimum of 5$ sent

        // the statement below requires that the minimum value be sent is >= 5 usd
        // because the 'msg.value' uses ETH to evaluate expressions we need a way to convert the 5 usd value to a value that works with msg.value

        // To do this we use an Oracle

        require(msg.value >= minimumUsd, "didn't send enough ETH");
        
    }

    // we will proceed to create a function to get the current price of eth in usd below
    function getPrice() public{
        // since we are trying to interact with another contract we need 2 things; the contract address and the ABI
        // eth/usd address for sepolia is 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // Remember the ABI is just a list of functions belonging to a specific contract
        // to get the ABI we can go to the contract on github and copy paste the code to the top of this contract and use the 'interface' keyword to work with it
        // after doing that we can use the interface of the contract copied above to make calls for the price like so

        // AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).description();
        // the code above is calling the copy pasted interface code above and parsing in the contract address for the sepolia eth/usd price feed
        // you can run the code by calling any one of the methods in the AggregatorV3Interface interface contract

    }

    // we will also create another function to perform the conversion between usd and eth
    function getConversionRate() public{}


    // the function below is created specifically to showcase how to call a method from the interface contract above
    function getDescription() public view returns (string memory) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).description();
    }


    // a function that the owner of the contract is going to use to withdraw money
    // function withdraw() public {}
}


