// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{

    function getPrice() internal view returns(uint256){
        
        // we're going to deploy the contract to zksync sepolia testnet and so we'll change the chainlink pricefeed address to the zksync one
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        
        (,int256 price,,,)= pricefeed.latestRoundData();
        return uint256(price * 1e10);
    }


    // the function below will take an eth value and convert it to dollars
    function getConversionRate(uint256 ethvalue) internal view returns(uint256) {
        
        uint256 ethprice = getPrice();
        uint256 ethAmountInUSD = (ethvalue * ethprice)/1e18;
        return ethAmountInUSD;
        
    }

}

//another way we can optimize for gas is by using custom error handling in solidity
error NotOwner();
// we can then use this in the modifier error handling by using an 'if' statement

contract FundMe {
    
    using PriceConverter for uint256;

   
    uint256 public constant MINIMUM_USD = 5e18;
   

    address[] public funders;
    mapping(address => uint256) public AddressToAmountFunded;

    address public immutable i_owner;
   

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {

        require(msg.value.getConversionRate() >= MINIMUM_USD,"didn't send enough ETH");
        
        funders.push(msg.sender);

        
        AddressToAmountFunded[msg.sender] += msg.value;
        
    }
    
    function withdraw() public onlyOwner {
        

       
        for (uint256 FunderIndex = 0; FunderIndex < funders.length; FunderIndex = FunderIndex + 1 ) {
            address funder = funders[FunderIndex];
            AddressToAmountFunded[funder] = 0;
            }
        

        funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess,"Call failed");
    }

   
    modifier onlyOwner() {
        // require(msg.sender == i_owner,"sender is not owner!");
        
        if(msg.sender != i_owner){
            revert NotOwner();
        }
        // so now instead of using the string revert above, we just use the NotOwner custom error we defined above
        _;
    }


    receive() external payable {
        // and then we'll just have the receive function call the 'fund' function above
        fund();
     } 

    
    fallback() external payable {
        fund();
     }

}


