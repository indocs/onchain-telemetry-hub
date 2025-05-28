// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// A tiny gas-optimized math helper using unchecked addition. This library
// is intentionally lightweight and not tied to any specific contract state.
// It can be leveraged by other contracts to reduce gas costs on simple sums.
library GasMath {
    // Adds two numbers using unchecked to save gas where overflow is impossible by design.
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            return a + b;
        }
    }
}
