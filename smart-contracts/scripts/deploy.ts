import { ethers } from "hardhat";

async function main() {
  // Get the contract factory
  const YourContract = await ethers.getContractFactory("PaywithBTCWithEncryption");
  
  console.log("Deploying contract...");
  
  // Deploy the contract
  const contract = await YourContract.deploy(/* constructor arguments if any */);
  await contract.waitForDeployment();
  
  const address = await contract.getAddress();
  console.log(`Contract deployed to: ${address}`);
}

// Handle errors
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});