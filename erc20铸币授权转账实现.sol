// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract MyToken{


//代币名称
string public  name = "MyToken";
//代币符号
string public  symbol = "MTK";
//代币小数位数
uint8 public decimals = 18;
//总供应量
uint256 public totalSupply;

//余额映射
mapping (address => uint256) public balanceOf;

//授权额度映射
mapping (address => mapping (address => uint256)) public  allowance;


//转账事件
event Transfer(address indexed from,address indexed to,uint256 value);

//授权事件
event Approval(address indexed  owner,address indexed  spender,uint256 value);


    //初始化币
    constructor(uint256 initialSuuply){
        
        totalSupply = initialSuuply*10**uint256(decimals);
        balanceOf[msg.sender] = totalSupply; // 将总供应量分配给部署者
        emit Transfer(address(0), msg.sender, totalSupply);
        //// 从零地址转账，表示代币铸造
        
    }

    //转账函数
    function transfer (address _to,uint256 _value) public returns (bool success){
       //判断余额是否充足
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        balanceOf[msg.sender] -=_value; //扣除余额
        balanceOf[_to]+= _value;//增加余额
        emit Transfer(msg.sender,_to,_value);  //发送转账事件
        return  true;
    }

    //授权函数
    function approve(address sender,uint256 value) public returns (bool success){
    
        allowance[msg.sender][sender] = value;
        emit Approval(msg.sender, sender, value);
        return  true;   
    } 
     
    //转账授权函数
    function transferFrom(address from,address to,uint256 value)public returns (bool success){

         //余额大于转账额度   
         require(balanceOf[from] >= value,"Insufficient balance");
         //授权额度大于转账额度
         require(allowance[from][msg.sender] >= value, "Allowance exceeded");
         balanceOf[from] -= value;
         balanceOf[to] += value;
         allowance[from][msg.sender] -= value;
         emit Transfer(from, to, value);
         return true;
    }


}
