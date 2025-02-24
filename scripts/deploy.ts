// Deploy script for local or test networks
import { ethers } from "hardhat";
import * as dotenv from "dotenv";

dotenv.config();

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying from", deployer.address);

  const TelemetryHub = await ethers.getContractFactory("TelemetryHub");
  // initial sampling interval for demonstration
  const initialInterval = 60;
  const hub = await TelemetryHub.deploy(initialInterval);
  await hub.deployed();
  console.log("TelemetryHub deployed at", hub.address);

  // Admin can grant operator role to a specified address if provided
  const operator = process.env.OPERATOR_ADDRESS;
  if (operator) {
    await hub.connect(deployer).setOperator(operator);
    console.log("Operator granted to", operator);
  }
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });
