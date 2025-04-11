// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VariableScope {
    // 1️⃣ State Variable (Stored on blockchain, persists after function execution)
    uint public stateVar = 100;

    // 2️⃣ Global Variable (Provides blockchain data)
    address public owner;

    constructor() {
        owner = msg.sender;  // Assign deployer's address to owner
    }

    function exampleFunction() public view returns (uint) {
        // 3️⃣ Local Variable (Exists only inside this function)
        uint localVar = 50;
        
        // Returning sum of state variable and local variable
        return stateVar + localVar;
    }

    function getBlockInfo() public view returns (uint, address) {
        return (block.timestamp, msg.sender); // Global variables
    }
}
