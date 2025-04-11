// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// Importing Chainlink's AggregatorV3Interface for fetching price data
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol"; // Importing a custom library for price conversion

// Custom error for unauthorized access
error NotOwner();

contract FundMe {
    using PriceConverter for uint256; // Using the PriceConverter library for uint256

    // Mapping to store the amount funded by each address
    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders; // Array to keep track of all funders

    address public immutable i_owner; // Owner of the contract (set once at deployment)
    uint256 public constant MINIMUM_USD = 50 * 10 ** 18; // Minimum funding amount required in USD (scaled for precision)
    
    // Constructor sets the contract deployer as the owner
    constructor() {
        i_owner = msg.sender;
    }

    // Function to allow users to fund the contract
    function fund() public payable {
        // Ensure that the amount sent is greater than the minimum required amount (converted to USD)
        require(msg.value.getConversionRate() >= MINIMUM_USD, "You need to spend more ETH!");
        
        // Store the amount funded by the sender
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender); // Add the sender to the funders list
    }
    
    // Function to fetch the version of the Chainlink price feed
    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }
    
    // Modifier to restrict access to only the owner
    modifier onlyOwner {
        if (msg.sender != i_owner) revert NotOwner(); // Custom error handling
        _; // Continue execution
    }
    
    // Function to withdraw all funds from the contract (only callable by the owner)
    function withdraw() public onlyOwner {
        // Reset the balance of each funder
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        
        // Reset the funders array
        funders = new address[](0);
        
        // Transfer the contract's balance to the owner
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    // Fallback function to accept ETH and call the fund function
    fallback() external payable {
        fund();
    }

    // Receive function to accept ETH and call the fund function
    receive() external payable {
        fund();
    }
}
