// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TelemetryHub.sol";

// Lightweight extension to TelemetryHub to expose a simple version getter for tests
contract TelemetryHubExt is TelemetryHub {
    function getVersion() public pure returns (uint256) {
        return 1;
    }
}
