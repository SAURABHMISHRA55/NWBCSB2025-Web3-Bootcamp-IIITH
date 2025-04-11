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
        require(!votingOpen, "Cannot register candidates after voting has started");
        candidates.push(Candidate(_name, 0));
    }
    
    // Function to start voting (only admin should be able to call this)
    function startVoting() public {
        require(msg.sender == admin, "Only admin can start voting");
        require(!votingOpen, "Voting is already open");
        votingOpen = true;
    }
    
    // Function to cast a vote
    function vote(uint candidateIndex) public {
        require(votingOpen, "Voting is not open");
        require(!hasVoted[msg.sender], "You have already voted");
        require(candidateIndex < candidates.length, "Invalid candidate index");
        
        hasVoted[msg.sender] = true;
        candidates[candidateIndex].voteCount++;
    }
    
    // Function to stop voting (only admin should be able to call this)
    function stopVoting() public {
        require(msg.sender == admin, "Only admin can stop voting");
        require(votingOpen, "Voting is already closed");
        votingOpen = false;
    }
    
    // Function to get total votes for a candidate
    function getVotes(uint candidateIndex) public view returns (uint) {
        require(candidateIndex < candidates.length, "Invalid candidate index");
        return candidates[candidateIndex].voteCount;
    }
    
    // Function to get the winner
    function getWinner() public view returns (string memory) {
        require(!votingOpen, "Voting is still in progress");
        require(candidates.length > 0, "No candidates available");
        
        uint winningVoteCount = 0;
        string memory winner;
        
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winner = candidates[i].name;
            }
        }
        
        return winner;
    }
}
