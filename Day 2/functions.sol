// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Parent Contract (Demonstrates Function Visibility and External Calls)
contract ParentContract {
    uint private secretNumber = 42;  // Private state variable
    address public owner;

    constructor() {
        owner = msg.sender;  // Sets contract deployer as owner
    }

    // 1️⃣ Function Visibility Modifiers

    function publicFunction() public pure returns (string memory) {
        return "I am public and anyone can call me!";
    }

    function privateFunction() private pure returns (string memory) {
        return "I am private and only accessible inside this contract!";
    }

    function internalFunction() internal pure returns (string memory) {
        return "I am internal and can be accessed by child contracts!";
    }

    function externalFunction() external pure returns (string memory) {
        return "I am external and only callable from outside!";
    }

    // 2️⃣ Function Mutability (view, pure, payable)

    function getSecretNumber() public view returns (uint) {
        return secretNumber;  // Uses 'view' because it reads state
    }

    function addNumbers(uint a, uint b) public pure returns (uint) {
        return a + b;  // Uses 'pure' because it does not read or modify state
    }

    function depositEther() public payable {
        // Uses 'payable' to allow sending Ether to this function
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;  // Returns the balance of the contract
    }

    // 3️⃣ Returning Single & Multiple Values

    function getOwner() public view returns (address) {
        return owner;
    }

    function getMultipleValues() public pure returns (string memory, uint) {
        return ("Solidity Functions", 100);
    }

    // 4️⃣ Function Modifier (Restricting Access)
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner!");
        _;
    }

    function restrictedFunction() public onlyOwner {
        // This function can only be called by the owner
    }

    // 5️⃣ Function Overloading

    function setValue(uint _value) public pure returns (uint) {
        return _value;
    }

    function setValue(uint _value, string memory _message) public pure returns (string memory, uint) {
        return (_message, _value);
    }

    // 6️⃣ Calling Functions within Contract
    function callInternalFunction() public pure returns (string memory) {
        return internalFunction();  // Calls internal function inside the same contract
    }
}

// 7️⃣ Calling Functions from Another Contract (Child Contract Inheriting ParentContract)
contract ChildContract is ParentContract {
    function callParentInternalFunction() public pure returns (string memory) {
        return internalFunction();  // Allowed because it's internal
    }
}

// 8️⃣ Calling External Functions from Another Contract
contract ExternalCaller {
    ParentContract public parentContract;

    constructor(address _parentAddress) {
        parentContract = ParentContract(_parentAddress);
    }

    function callExternalFunction() public view returns (string memory) {
        return parentContract.externalFunction();  // Calls external function from another contract
    }
}
