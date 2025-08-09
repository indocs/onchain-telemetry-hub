// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AccessControl.sol";

// Lightweight utilities guarded by AccessControl roles to tighten security
// This contract is intentionally minimal and additive to the existing codebase.
contract SecuredUtilities is AccessControl {
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");

    // Initialize with a deployer/admin having DEFAULT_ADMIN_ROLE
    constructor(address admin) {
        _setupRole(DEFAULT_ADMIN_ROLE, admin);
        _setRoleAdmin(OPERATOR_ROLE, DEFAULT_ADMIN_ROLE);
    }

    // Example guarded action that only an operator can perform
    function guardedAction() external onlyRole(OPERATOR_ROLE) {
        // Intentionally empty: serves as a hook for future guarded operations
    }

    // Allow the admin to grant operator role to another address
    function grantOperator(address op) external onlyRole(DEFAULT_ADMIN_ROLE) {
        grantRole(OPERATOR_ROLE, op);
    }

    // Optional: revoke operator if needed in future governance flows
    function revokeOperator(address op) external onlyRole(DEFAULT_ADMIN_ROLE) {
        revokeRole(OPERATOR_ROLE, op);
    }
}
