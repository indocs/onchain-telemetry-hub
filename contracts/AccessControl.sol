// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Minimal access control with a single owner. This can be imported by existing contracts
// to tighten ownership semantics without pulling in heavy dependencies.
contract AccessControl {
    address public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        owner = msg.sender;
        emit OwnershipTransferred(address(0), owner);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "AccessControl: caller is not the owner");
        _;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "AccessControl: new owner is the zero address");
        address oldOwner = owner;
        owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }

    function isOwner(address account) external view returns (bool) {
        return account == owner;
    }
}
