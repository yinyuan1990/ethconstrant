
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract LogicA {

   
    uint256 public  value;
    

    function setValue(uint256 newvalue) public payable {
         value = newvalue;
    }


    function getCzc() public  pure  returns  (bytes32){

       // 计算存储槽
        bytes32 slot = bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1);
               
        return  slot;
    } 


}
