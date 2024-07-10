// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import {PriceConverter} from "./PriceConverter.sol";

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
}


