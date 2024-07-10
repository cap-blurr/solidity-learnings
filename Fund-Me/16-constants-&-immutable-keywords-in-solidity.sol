// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import {PriceConverter} from "./PriceConverter.sol";

// Rn deploying this contract costs 888,965 gas,which is kinda expensive
// But we can use a couple of tricks to bring that number down and optimize our contracts
// The tricks we'll use are the 'constant' and 'immutable' keywords

// Constants are variables that cannot be modified. Their value is hard coded and using constants can save gas cost.

// Immutable variables are like constants. Values of immutable variables can be set inside the constructor but cannot be modified afterwards.
contract FundMe {
    
    using PriceConverter for uint256;

    // for example we can add the constant keyword here since this variable is never changed
    // what this does is that now the 'minimumUsd' variable doesnt take up storage space when the contract is deployed
    // if we deploy the contract now,we'll find that we've reduced gas usage to 865,572 ; savings of 23,393 or about as much as it costs to currently send eth
    uint256 public constant MINIMUM_USD = 5e18;
    // we've changed the name to caps since that is the naming convention for constant variables

    address[] public funders;
    mapping(address => uint256) public AddressToAmountFunded;

    // another optimization we can make is here since this variable is only used once in the constructor
    // for variables we set one time but outside the line they are declared we use the 'immutable' keyword
    address public immutable i_owner;
    // a naming convention to use with immutable variables is to include 'i_' before the variable to notify others that this is an immutable variable
    // our current gas costs are at 838,939 another extra savings of 26,633!
    
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
        require(msg.sender == i_owner,"sender is not owner!");
        _;
    }
}


