
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// 导入 OpenZeppelin 的 ERC-20 实现
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract MyTokenERC is ERC20,ReentrancyGuard{


    constructor(
     string memory name,
     string memory symbol,
     uint256 num
    ) ERC20(name,symbol){
        _mint(msg.sender, num*10**decimals());
        
    }

    function safeTransfer(address to,uint256 value) public nonReentrant {
            _transfer(msg.sender, to, value);
    } 
    

    
}
