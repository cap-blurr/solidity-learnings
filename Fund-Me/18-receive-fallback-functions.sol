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

    // another issue we deal with is what happens when someone send ETH to this contract without using the fund contract ...
    //... like just sending ETH to the contract address?

    // This is where 'Special Functions' come in, which are :
    // - receive()
    // - fallback()

    /* The 'receive()' callback is called if 'msg.data' or 'calldata' in remix, is empty otherwise 'fallback()' is called */

    // A contract can have at most ONE OF EACH

    // 'receive()' is declared using 'receive external payable()' and without the 'function' keyword
    // 'fallback()' is declared using ''fallback () external [payable]'' or ''fallback (bytes calldata input) external [payable] returns (bytes memory output)'' (both without the function keyword)
    // you only need to include 'payable' when declaring 'fallback' only when your sending ETH,otherwise if you're only sending data

    // So in our current Fundme contract,we can include a 'receive()' function just incase someone wants to fund the contract without using the 'fund' function
    receive() external payable {
        // and then we'll just have the receive function call the 'fund' function above
        fund();
     } 

    // we'll also do the same thing with our 'fallback()' function
    fallback() external payable {
        fund();
     }

     // now if we deploy our contract to a testnet and directly send the contract address money,the funds will be reflected in the contract
}


