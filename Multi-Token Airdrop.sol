// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MultiTokenAirdrop {
    address public admin;

    event AirdropExecuted(address indexed sender, address[] recipients, uint256[] amounts, address[] tokens);

    constructor() {
        admin = msg.sender;
    }

    function airdrop(address[] calldata recipients, uint256[] calldata amounts, address[] calldata tokens) external {
        require(msg.sender == admin, "Only admin can execute airdrop");
        require(recipients.length == amounts.length && amounts.length == tokens.length, "Arrays must be the same length");

        for (uint i = 0; i < recipients.length; i++) {
            IERC20(tokens[i]).transferFrom(msg.sender, recipients[i], amounts[i]);
        }

        emit AirdropExecuted(msg.sender, recipients, amounts, tokens);
    }
}

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}