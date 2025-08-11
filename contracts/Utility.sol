// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// tiny utility contract added to extend repository without affecting core logic
// serves as a lightweight sanity check for deployment/build tooling
contract Utility {
    // simple ping function to verify contract can be deployed and interacted with
    function ping() external pure returns (bool) {
        return true;
    }
}
