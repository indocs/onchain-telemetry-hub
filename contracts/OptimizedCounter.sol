// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// A lightweight, gas-efficient counter contract intended as a small utility
// to showcase and test gas-optimized patterns without affecting existing logic.
// This contract can be deployed alongside the TelemetryHub project and used in
// tests or scripts as a simple counter utility.

contract OptimizedCounter {
    uint256 private _count;

    constructor(uint256 start) {
        _count = start;
    }

    // Increment without overflow checks to save gas in common use-cases.
    // Safe in practice for counters that won't reach 2^256-1.
    function increment() external {
        unchecked { _count += 1; }
    }

    function get() external view returns (uint256) {
        return _count;
    }
}
