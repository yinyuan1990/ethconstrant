// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract MyContract is Ownable {
    
    uint256 public value;

    constructor() Ownable(msg.sender){
        
    }

    // 仅允许所有者更新值
    function setValue(uint256 newValue) public onlyOwner {
        value = newValue;
    }
    
    // 所有者可以转移所有权
    function transferOwnership(address newOwner) public override onlyOwner {
       
        _transferOwnership(newOwner);
    }

    

}
