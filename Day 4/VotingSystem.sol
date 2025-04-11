// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    struct Candidate {
        string name;
        uint voteCount;
    }
    
    address public admin;
    bool public votingOpen;
    mapping(address => bool) public hasVoted;
    Candidate[] public candidates;
    
    constructor() {
        admin = msg.sender;
    }
    
    // Function to register a candidate (only admin should be able to call this)
    function registerCandidate(string memory _name) public {
        require(msg.sender == admin, "Only admin can register candidates");
        // TODO: Require that voting has not started yet
        candidates.push(Candidate(_name, 0));
    }
    
    // Function to start voting (only admin should be able to call this)
    function startVoting() public {
        // TODO: Implement admin check
        votingOpen = true;
    }
    
    // Function to cast a vote
    function vote(uint candidateIndex) public {
        // TODO: Require that voting is open
        // TODO: Ensure voter has not voted before (check hasVoted mapping)
        // TODO: Ensure the candidate index is valid
        hasVoted[msg.sender] = true;
        // TODO: Increated the vote for candidateIndex
    }
    
    // Function to stop voting (only admin should be able to call this)
    function stopVoting() public {
        require(msg.sender == admin, "Only admin can stop voting");
        votingOpen = false;
    }
    
    // Function to get total votes for a candidate
    function getVotes(uint candidateIndex) public view returns (uint) {
        // TODO: Ensure candidateIndex is valid
        return candidates[candidateIndex].voteCount;
    }
    
    // Function to get the winner (not implemented)
    function getWinner() public view returns (string memory) {
        // TODO: Implement logic to find and return the candidate with the highest votes
        require(!votingOpen, "Voting is still in progress");
        return "Winner logic not implemented";
    }
}
