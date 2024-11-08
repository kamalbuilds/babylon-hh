## Requirements

Before you begin, you need to install the following tools:

- [Node (>= v18.17)](https://nodejs.org/en/download/)
- [Git](https://git-scm.com/downloads)
- [Foundry](https://book.getfoundry.sh/getting-started/installation)

## Quick start
```

1. Install Dependencies

```bash
npm install
```

2. Compile and Test Contracts

```bash
forge build
forge test
```

3. Deploy contracts

To deploy the contracts to the Optimism/BNB/Linea networks, first fill out the `.envexample` template and rename it to `.env`. Then, run the deployment script:

```bash
npx hardhat deploy --network NETWORK_NAME
```

## Smart contracts

This project consists of the following smart contracts:

- [KeyRegistry](./contracts/KeyRegistry.sol)
- [PaywithBTCWithEncryption](./contracts/PaywithBTCWithEncryption.sol)

## KeyRegistry.sol

## Contract Overview

KeyRegistry represents the main register for stealth-meta addresses. The contract ensures the validity and uniqueness of addresses before registering them, enabling secure and organized data.
