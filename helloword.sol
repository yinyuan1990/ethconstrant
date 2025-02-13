// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract HelloWorld {

   string public message; // 动态字符串 动态字节  gas 高 存储/读取
   address public owner; //eth地址 固定20字节。   gas 低 存储/读取 

    constructor(string memory _message){

        message = _message;
        owner = msg.sender;

    }

    function setMessage(string memory newMsg) public {
         require(msg.sender == owner,"Only owner can change the message");
         message = newMsg;
    }



}
