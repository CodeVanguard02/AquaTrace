require("dotenv").config();
const { ethers } = require("ethers");
const { JsonRpcProvider } = require("ethers").providers;

// Load environment variables
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const INFURA_PROJECT_ID = process.env.INFURA_PROJECT_ID;
const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS;

const NETWORK = "sepolia";

// ABI of the deployed contract (copy this from your compiled contract in Remix)
const ABI = [
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "string",
        name: "toolId",
        type: "string",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "oldPrice",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "newPrice",
        type: "uint256",
      },
    ],
    name: "PriceUpdated",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "string",
        name: "toolId",
        type: "string",
      },
      {
        indexed: true,
        internalType: "address",
        name: "user",
        type: "address",
      },
      {
        indexed: false,
        internalType: "string",
        name: "action",
        type: "string",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "timestamp",
        type: "uint256",
      },
    ],
    name: "TransactionLogged",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "toolId",
        type: "string",
      },
    ],
    name: "getToolPrice",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "toolId",
        type: "string",
      },
      {
        internalType: "uint256",
        name: "index",
        type: "uint256",
      },
    ],
    name: "getTransaction",
    outputs: [
      {
        internalType: "string",
        name: "action",
        type: "string",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "timestamp",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "toolId",
        type: "string",
      },
    ],
    name: "getTransactionCount",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "toolId",
        type: "string",
      },
      {
        internalType: "string",
        name: "action",
        type: "string",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
    ],
    name: "logTransaction",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "toolId",
        type: "string",
      },
      {
        internalType: "uint256",
        name: "price",
        type: "uint256",
      },
    ],
    name: "setToolPrice",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];

const provider = new JsonRpcProvider(
  `https://${NETWORK}.infura.io/v3/${INFURA_PROJECT_ID}`
);

// Create a signer
const wallet = new ethers.Wallet(PRIVATE_KEY, provider);

// Create a contract instance
const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, wallet);

// Example function to do something
function doSomething() {
  // Code goes here
}

// Example function to set the price of a tool
async function setToolPrice(toolId, price) {
  const tx = await contract.setToolPrice(toolId, price);
  await tx.wait();
  console.log(`Tool price for ${toolId} set to ${price}`);
}

// Example function to get the price of a tool
async function getToolPrice(toolId) {
  const price = await contract.getToolPrice(toolId);
  console.log(`Tool price for ${toolId} is ${price.toString()}`);
  return price;
}

// Example function to log a transaction
async function logTransaction(toolId, action, amount) {
  const tx = await contract.logTransaction(toolId, action, amount);
  await tx.wait();
  console.log(
    `Logged transaction for ${toolId}: ${action} with amount ${amount}`
  );
}

// Example function to get the number of transactions for a tool
async function getTransactionCount(toolId) {
  const count = await contract.getTransactionCount(toolId);
  console.log(`Number of transactions for ${toolId}: ${count.toString()}`);
  return count;
}

// Example function to get a specific transaction
async function getTransaction(toolId, index) {
  const transaction = await contract.getTransaction(toolId, index);
  console.log(
    `Transaction at index ${index} for ${toolId}: ${
      transaction.action
    }, Amount: ${transaction.amount.toString()}, Timestamp: ${
      transaction.timestamp
    }`
  );
  return transaction;
}

// Example usage
(async () => {
  // Replace with your toolId
  const toolId = "tool1";

  // Set tool price
  await setToolPrice(toolId, 100);

  // Get tool price
  await getToolPrice(toolId);

  // Log a transaction
  await logTransaction(toolId, "Purchase", 100);

  // Get transaction count
  await getTransactionCount(toolId);

  // Get a specific transaction
  await getTransaction(toolId, 0);
})();
