// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/Address.sol";


/*

调用方式	能否修改状态变量	能否发送 ETH	能否 selfdestruct
call	✅ 可以（修改目标合约的状态）	✅ 可以	✅ 可以
delegatecall	✅ 可以（但修改的是调用合约的存储！）	✅ 可以	✅ 可以（但销毁的是调用合约）
staticcall	❌ 不能修改状态	❌ 不能	❌ 不能

abi.decode(arg, arg);
abi.encode(arg);

*/

contract addresstest{
  
   using Address for address;

   function checkIfContract(address target) public view returns (bool){
        return  target.code.length>0; // 3. 正确调用绑定后的方法;
   }
   
   function sendEth(address payable  target) public payable {
        require((target.code.length>0)==false,"");
        target.transfer(msg.value);  //转账到traget        
   } 
   
     

}
