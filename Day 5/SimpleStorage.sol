// I'm a comment!
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;
// pragma solidity ^0.8.0;
// pragma solidity >=0.8.0 <0.9.0;

contract SimpleStorage { 

uint256 favoriteNumber; 
 
struct People { 
    string name; 
    uint256 favoriteNumber; 
} 
 
People[] public people; 
mapping(uint256 => string) public favoriteNumberToName; // Mapping favorite number to name 
 
function store(uint256 _favoriteNumber) public virtual { 
    favoriteNumber = _favoriteNumber; 
} 
 
function retrieve() public view returns (uint256) { 
    return favoriteNumber; 
} 
 
function addPerson(string memory _name, uint256 _favoriteNumber) public { 
    people.push(People(_name, _favoriteNumber)); 
    favoriteNumberToName[_favoriteNumber] = _name; // Store favorite number as key, name as value 
} 
 
function getPersonByFavoriteNumber(uint256 _favoriteNumber) public view returns (string memory) { 
    if (bytes(favoriteNumberToName[_favoriteNumber]).length == 0) { 
        return "Number not found"; // Check if the number exists 
    } 
    return favoriteNumberToName[_favoriteNumber]; 
} 
  

} 