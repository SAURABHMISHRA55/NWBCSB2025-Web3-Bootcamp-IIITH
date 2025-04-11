// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataTypesExample {
    // 1️⃣ Value Types (Stored directly in memory)
    bool public isActive = true;  // Boolean
    uint public positiveNumber = 100;  // Unsigned integer
    int public negativeNumber = -50;  // Signed integer
    address public owner = msg.sender;  // Address of contract deployer
    bytes32 public hashValue = keccak256(abi.encodePacked("Hello Solidity"));  // Bytes data type
    string public greeting = "Hello, Blockchain!";  // String

    // 2️⃣ Reference Types (Point to data storage)
    uint[] public numbers;  // Dynamic array

    struct Person {
        string name;
        uint age;
    }
    Person public user = Person("Alice", 25);  // Struct Example

    mapping(address => uint) public balances;  // Mapping Example

    // 3️⃣ Special Types (Enums)
    enum Status { Pending, Approved, Rejected }
    Status public applicationStatus = Status.Pending;

    // Function to add a number to the array
    function addNumber(uint _num) public {
        numbers.push(_num);
    }

    // Function to update mapping
    function setBalance(address _user, uint _amount) public {
        balances[_user] = _amount;
    }
}
