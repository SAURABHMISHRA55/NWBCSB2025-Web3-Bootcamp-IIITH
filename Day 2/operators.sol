// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OperatorsExample {
    // 1️⃣ Arithmetic Operators
    function arithmeticOperations(uint a, uint b) public pure returns (uint, uint, uint, uint, uint) {
        return (
            a + b,   // Addition
            a - b,   // Subtraction
            a * b,   // Multiplication
            a / b,   // Division
            a % b    // Modulus (Remainder)
        );
    }

    // 2️⃣ Comparison Operators
    function comparisonOperators(uint a, uint b) public pure returns (bool, bool, bool, bool, bool, bool) {
        return (
            a == b,  // Equal to
            a != b,  // Not equal to
            a > b,   // Greater than
            a < b,   // Less than
            a >= b,  // Greater than or equal to
            a <= b   // Less than or equal to
        );
    }

    // 3️⃣ Logical Operators
    function logicalOperators(bool x, bool y) public pure returns (bool, bool, bool) {
        return (
            x && y,  // Logical AND
            x || y,  // Logical OR
            !x       // Logical NOT
        );
    }

    // 4️⃣ Bitwise Operators
    function bitwiseOperators(uint a, uint b) public pure returns (uint, uint, uint, uint, uint, uint) {
        return (
            a & b,  // Bitwise AND
            a | b,  // Bitwise OR
            a ^ b,  // Bitwise XOR
            ~a,     // Bitwise NOT
            a << 1, // Left shift
            b >> 1  // Right shift
        );
    }

    // 5️⃣ Assignment Operators
    function assignmentOperators() public pure returns (uint) {
        uint num = 10;  
        num += 5;  // Same as num = num + 5;
        return num;  // Returns 15
    }
}
