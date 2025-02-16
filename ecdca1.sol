
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";

contract EIP712Verifier is EIP712 {
    using ECDSA for bytes32;

    // 1. 定义结构化消息的类型名称和字段
    bytes32 private constant TRANSACTION_TYPEHASH =
        keccak256("Transaction(address from,address to,uint256 amount,uint256 nonce)");

    mapping(address => uint256) public nonces;

    // 2. 继承 EIP712 并初始化域参数
    constructor() 
        EIP712("EIP712Verifier", "1.0.0") // 传入合约名称和版本号
    {}

    function executeTransfer(
        address to,
        uint256 amount,
        bytes calldata signature
    ) external {
        address from = msg.sender;
        uint256 currentNonce = nonces[from];

        // 3. 生成结构化消息哈希
        bytes32 structHash = keccak256(
            abi.encode(
                TRANSACTION_TYPEHASH,
                from,
                to,
                amount,
                currentNonce
            )
        );

        // 4. 生成完整 EIP-712 哈希（自动处理域分隔符和前缀）
        bytes32 fullHash = _hashTypedDataV4(structHash);

        // 5. 恢复签名者地址
        address signer = ECDSA.recover(fullHash, signature);
        require(signer == from, "Invalid signature");

        nonces[from]++;
        // 执行转账逻辑...
    }
}
