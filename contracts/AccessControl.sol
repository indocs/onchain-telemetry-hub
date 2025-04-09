// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This is a lightweight AccessControl-like shim used by the existing repo
// to provide role-based access control. It intentionally mirrors a subset
// of OpenZeppelin's AccessControl for simplicity in tests.

contract AccessControl {
    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;

    mapping(bytes32 => mapping(address => bool)) private _roles;

    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);
    event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);

    modifier onlyRole(bytes32 role) {
        require(hasRole(role, msg.sender), "AccessControl: access denied");
        _;
    }

    function hasRole(bytes32 role, address account) public view returns (bool) {
        return _roles[role][account];
    }

    function _grantRole(bytes32 role, address account) internal {
        _roles[role][account] = true;
        emit RoleGranted(role, account, msg.sender);
    }

    function _revokeRole(bytes32 role, address account) internal {
        _roles[role][account] = false;
        emit RoleRevoked(role, account, msg.sender);
    }

    // Lightweight public helper for tests and integrations
    function hasAdmin(address account) external view returns (bool) {
        return hasRole(DEFAULT_ADMIN_ROLE, account);
    }

    // New security-tight helper to expose role checks publicly for tests
    function hasRolePublic(bytes32 role, address account) external view returns (bool) {
        return hasRole(role, account);
    }
}
