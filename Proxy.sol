
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/StorageSlot.sol";
import "@openzeppelin/contracts/utils/Address.sol";

//数据在代理合约中
//逻辑在背调用中
//通过abi。en 调用逻辑合约

contract ProxyTest{
    

    uint256 public  value;

     // EIP-1967 规定的逻辑合约地址存储槽
    bytes32 private constant _IMPLEMENTATION_SLOT =
        0x360894A13BA1A3210667C828492DB98DCA3E2076CC3735A920A3CA505D382BBC;


    // 构造函数，初始化代理合约
    constructor(address _logic) payable {
        assert(_IMPLEMENTATION_SLOT == bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1));
        _setImplementation(_logic);
        
    }


   // 获取当前逻辑合约地址
    function _implementation() internal view returns (address impl) {
        return StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value;
    }

    // 设置新的逻辑合约地址
    function _setImplementation(address newImplementation) private {
        require((newImplementation.code.length>0)==true, "ERC1967: new implementation is not a contract");
        StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value = newImplementation;
    }


     /*
     fallback() external payable {
        address _impl = _implementation();
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), _impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
    */
    

}

