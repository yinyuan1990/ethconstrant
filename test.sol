
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract test{


      uint256 public number;

      //public external internal private
      // Gas 消耗：最低（几乎为 0，因为不涉及状态读写）。
      //对于状态变量，默认是 storage，可以省略。
      //对于局部变量（尤其是动态类型），必须显式声明 memory 或 storage，否则编译器会报错。 

      //pure 不修改也不读取合约状态 为0
      function addNumber(uint256 a,uint256 b) public pure returns (uint256){
          return  a+b;
      }
      
      //view 只读区合约状态。为0
      function getBalance() view public returns (uint256){
         return number;
      }

      function getBalance2() view public returns (uint256){
         return msg.sender.balance;
      }


      //payable 修改合约状态 描述  gas -- 44105
      function setNumber(uint256 newNumber) payable public {
           number = newNumber;
      }


     //  存储方式
     //如果结构体包含动态字段，Solidity 会使用 指针 来引用动态数据。
     //动态数据会存储在单独的存储槽中，而结构体本身只存储指针。
      
      //结构体
      struct User{
         uint256 id;
         string name;
         uint256 point;
      }  


       //map
     mapping(address => User) public users;

      //添加用户
      function addUser(uint256 id,string memory name) public {
           users[msg.sender] = User(id,name,0);
      }

      //更新用户余额
      function updatePoints(uint256 newpoint) payable public {
          users[msg.sender].point = newpoint;
      }


        /*
        Solidity 没有原生的小数类型。
        可以通过 定点数 或 开源库 来模拟小数运算。
        如果需要复杂的小数运算，可以将计算逻辑放在链下。
        ERC-20：适用于同质化代币（如货币、积分）。
        ERC-721：适用于非同质化代币（如艺术品、收藏品）。
        ERC-1155：适用于半同质化代币（如游戏道具、批量代币发行）。
        */






}
