// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// a good habit before starting to write code is to write the list of steps you need to do

// we need to get funds from users
// withdraw funds
// set a minimum funding value in USD in this case 5$

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    

    // now we can attach the functions in our PriceConverter Library to all 'uint256' we can do the following
    using PriceConverter for uint256;

    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping(address => uint256) public AddressToAmountFunded;


    function fund() public payable {

        require(msg.value.getConversionRate() >= minimumUsd,"didn't send enough ETH");
        
        funders.push(msg.sender);

        /*another hack you can do below is replace the '+ msg.value' to '+= msg.value' like so below*/
        AddressToAmountFunded[msg.sender] += msg.value;
        
    }
    
    // awesome now since we can use the 'fund' function above to fund the contract,we can now proceed and create a withdraw function to withdraw the funds

    function withdraw() public {
        // To withdraw the money,we're probably gonna need to reset all the mappings to zero and show there's no address left there
        // To accomplish this,we'll use a 'For' loop which just loops thru a list of items
        // to do a For loop in solidity the general format is ...
        // ... for (/* starting index,ending index,step amount*/)

        // so to loop thru our mapping we can do
        for (uint256 FunderIndex = 0; FunderIndex < funders.length; FunderIndex = FunderIndex + 1 /* or you can also use ++ instead of + 1 which is the same thing*/) {
            // the code below is setting the funder variable to the current index of the funders array in the loop
            address funder = funders[FunderIndex];

            // and then the code below sets the value of AddressToAmountFunded mapping to 0
            AddressToAmountFunded[funder] = 0;
        }
    }
}


