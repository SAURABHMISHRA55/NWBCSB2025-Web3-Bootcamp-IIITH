// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// Importing Chainlink's AggregatorV3Interface to fetch price data
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// Defining a library for price conversion utilities
library PriceConverter {
    
    // Function to get the latest ETH price in USD (scaled up for precision)
    function getPrice() internal view returns (uint256) {
        // Creating an instance of the Chainlink price feed contract
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306 // Address of the ETH/USD price feed on Ethereum
        );
        
        // Fetching the latest round data from the price feed
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        
        // Converting the price to a uint256 and adjusting for decimal precision (1e10)
        return uint256(answer * 10000000000); // Converts price from 8 decimal places to 18 decimal places
    }

    // Function to convert ETH amount to equivalent USD value
    function getConversionRate(uint256 ethAmount)
        internal
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice(); // Getting the current ETH price in USD
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; // Converting ETH to USD
        return ethAmountInUsd; // Returning the USD equivalent value
    }
}
