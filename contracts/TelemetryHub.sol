// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { AccessControl } from "@openzeppelin/contracts/access/AccessControl.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

/// @title OnChain Telemetry Hub
/// @notice A compact telemetry hub that records on-chain metrics with access control
/// and emits gas-aware telemetry events for dApp operators.
/// @dev This contract favors safety for upgrades and controlled access via roles.
contract TelemetryHub is AccessControl {
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");

    // Example of a reusable metric event carrying a simple payload and gas snapshot.
    event TelemetryEvent(string indexed metric, uint256 gasRemaining, address indexed operator);

    // Optional: track a global sampling rate; kept simple for demonstration.
    uint256 public samplingInterval;

    constructor(uint256 _initialInterval) {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(OPERATOR_ROLE, msg.sender);
        samplingInterval = _initialInterval;
    }

    /// @notice Admin can set the operator role to a new address.
    /// @param operator The address to grant the OPERATOR_ROLE.
    function setOperator(address operator) external {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "TeleHub: must be admin to set operator");
        require(operator != address(0), "TeleHub: operator is zero address");
        grantRole(OPERATOR_ROLE, operator);
    }

    /// @notice Operator can revoke their role from themselves to disable emission.
    function revokeOperator() external {
        require(hasRole(OPERATOR_ROLE, msg.sender), "TeleHub: not an operator");
        revokeRole(OPERATOR_ROLE, msg.sender);
    }

    /// @notice Update the sampling interval. Guarded by admin.
    function updateSamplingInterval(uint256 newInterval) external {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "TeleHub: only admin");
        samplingInterval = newInterval;
    }

    /// @notice Emit a telemetry event with a regard to current gas availability.
    /// The operator must have the OPERATOR_ROLE to call.
    /// @param metric A descriptive metric name or label.
    function recordEvent(string calldata metric) external {
        require(hasRole(OPERATOR_ROLE, msg.sender), "TeleHub: caller is not operator");
        // Basic gas check: we emit regardless, but we capture remaining gas for dashboards.
        uint256 remaining = gasleft();
        emit TelemetryEvent(metric, remaining, msg.sender);
    }
}
