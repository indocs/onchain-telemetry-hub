// Harden Hardhat config for TS
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  networks: {
    hardhat: {
      chainId: 1337
    },
  },
  paths: {
    tests: "./test",
    sources: "./contracts",
    artifacts: "./artifacts"
  },
  solidity: {
    compilers: [
      {
        version: "0.8.20"
      }
    ]
  },
  mocha: {
    timeout: 20000
  }
};

export default config;
