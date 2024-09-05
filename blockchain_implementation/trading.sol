// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WaterTrading {
    // Owner of the contract
    address public owner;

    // Price of water per unit (in wei)
    uint256 public waterPrice;

    // Event to log water purchases
    event WaterPurchased(address indexed buyer, uint256 amount, uint256 price);

    // Constructor sets the initial owner and water price
    constructor(uint256 initialPrice) {
        owner = msg.sender; // Set the contract deployer as the owner
        waterPrice = initialPrice; // Set the initial water price
    }

    // Modifier to restrict functions to the owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    // Function to update the water price (only owner can call this)
    function setWaterPrice(uint256 newPrice) public onlyOwner {
        waterPrice = newPrice;
    }

    // Function to purchase water
    function buyWater() public payable {
        require(msg.value >= waterPrice, "Insufficient funds to buy water.");

        // Calculate the amount of water the buyer can get for the sent ether
        uint256 amount = msg.value / waterPrice;

        // Log the purchase
        emit WaterPurchased(msg.sender, amount, waterPrice);

        // Transfer the funds to the owner
        payable(owner).transfer(msg.value);
    }

    // Function to get the current water price
    function getWaterPrice() public view returns (uint256) {
        return waterPrice;
    }
}
