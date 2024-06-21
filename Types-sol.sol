// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; //This is the solidity compiler version

contract Simplestorage {
    // basic types include Boolean, uint, int, address, bytes

    bool hasFavoritenumber = true; // this is either 'true' or 'false'
    uint256 favoritenumber = 88; // unsigned int type is any positive whole number
    string favoritenumbertext = "88"; // a string basically represents words in solidity
    int256 favoriteinteger = -88; // an int type can be any positive or negative whole number
    address myaddress = 0x0a1978f4CeC6AfA754b6Fa11b7D141e529b22741; // an ethereum public address
    bytes32 favoritebytes = "cat"; // strings are basically bytes objects but specifically for text
    // bytes are represented as hexa-decimal figures.
    // 'bytes2-32' are different from just 'bytes'

    // all types in solidity have a default value if one is not set
    // the semicolon at the end of each statement tells the compiler that a statement has been completed

}
