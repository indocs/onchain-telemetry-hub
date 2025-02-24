import { expect } from 'chai';
import { ethers } from 'hardhat';

describe('TelemetryHub', function () {
  it('should deploy and allow admin to grant operator', async function () {
    const [admin, operator] = await ethers.getSigners();
    const TelemetryHub = await ethers.getContractFactory('TelemetryHub');
    const hub = await TelemetryHub.connect(admin).deploy(30);
    await hub.deployed();

    // operator should not yet have role
    await expect(hub.connect(operator).recordEvent('test')).to.be.revertedWith(/caller is not operator/);

    // grant operator role
    await hub.connect(admin).setOperator(operator.address);

    // now operator can emit
    await expect(hub.connect(operator).recordEvent('test-metric'))
      .to.emit(hub, 'TelemetryEvent')
      .withArgs('test-metric', anything, operator.address);
  });
});
