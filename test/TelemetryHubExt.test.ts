import { expect } from "chai";
import { ethers } from "hardhat";

describe("TelemetryHubExt", function () {
  it("should deploy and return version 1", async function () {
    const Factory = await ethers.getContractFactory("TelemetryHubExt");
    const ext = await Factory.deploy();
    await ext.deployed();

    expect(await ext.getVersion()).to.equal(1);
  });
});
