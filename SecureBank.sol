

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//修复漏洞（Checks-Effects-Interactions）


contract SecureBank {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // 修复：先更新状态再转账
    function withdraw() external {
        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0; // Effects：先更新余额
        (bool success, ) = msg.sender.call{value: amount}(""); // Interactions：后转账
        require(success, "Transfer failed");
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
