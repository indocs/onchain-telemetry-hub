// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Lightweight auxiliary contract to provide a deterministic version string for tests and tooling.
contract TelemetryHubVersion {
    function getVersion() public pure returns (string memory) {
        return "0.0.1";
    }
}
