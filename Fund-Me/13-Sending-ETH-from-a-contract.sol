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


        // for loop option for resetting array
        for (uint256 FunderIndex = 0; FunderIndex < funders.length; FunderIndex = FunderIndex + 1 /* or you can also use ++ instead of + 1 which is the same thing*/) {
            // the code below is setting the funder variable to the current index of the funders array in the loop
            address funder = funders[FunderIndex];
            AddressToAmountFunded[funder] = 0;
            }
        
        
        // reset array options
        funders = new address[](0);

        // actually withdrawing the funds
        // There are 3 different ways of sending eth from a contract which are
        // - transfer
        // - send 
        // - call


        // 1) TRANSFER METHOD BELOW

        // To transfer funds we can do this
        // and then we need to type cast the 'msg.sender' variable from an 'address' type to a 'payable' address type
        /* msg.sender is type = address
            payable is of type = payable address*/
        payable(msg.sender).transfer(address(this).balance);
        // The 'this' keyword refers to this current contract
        // in solidity in order to send native tokens like eth you can only do that with the 'payable' keyword

        // The problem with using TRANSFER is that it uses 2300 gas and if the gas amount exceeds that it throws an error and reverts the tx
    


        // 2) SEND METHOD BELOW
        // With the SEND method if the gas amount is exceeded, it will instead return a bool instead of an error
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess,"error send failed");
        // The code above uses a boolean type variable to check if the send was successful since SEND returns a bool value
        // SEND will only revert if we add the require statement like above



        // 3) CALL METHOD BELOW
        // The CALL method is incredibly powerful in solidity and it can even be used to call any function in solidity without needing to use the ABI
        // To use the CALL method we do
        (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}("");
        // The brackets in call are used to put any function info or any info about the function we wanna call using it.
        // but in the example above it is left blank denoted by using 2 quotes and instead we want to use it as a tx
        // so instead we use curly brackets to denote using it as a transaction

        // CALL actually returns 2 variables which are a boolean and a bytes object which are denoted by...
        // ... adding brackets before the statement and including the variables

        // If CALL returns a value we'll save that in the 'dataReturned' var we have created above
        // it also returns callSuccess which will either be True or False depending on if the call fails or succeeds


        // since our call isnt calling a function and thus isnt returning a value we can remove the dataReturned attribute...
        // and then use the require statement similar to SEND above
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess,"Call failed");
    }
}


