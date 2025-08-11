// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Lightweight helper to estimate gas for a call. This is intentionally minimal
// and safe to include in the repo for incremental gas-related utilities.
// It can be used by scripts or tests to provide a rough upper bound for gas.
contract GasEstimator {
    // Returns an inflated estimate of base gas by adding a small buffer.
    function estimateGasForCall(uint256 base) public pure returns (uint256) {
        // Add a conservative 2100 gas buffer commonly used for basic refunds/calls.
        // This keeps it simple and deterministic without importing heavy math libs.
        return base + 2100;
    }
}
