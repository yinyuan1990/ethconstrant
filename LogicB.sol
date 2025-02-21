// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract LogicB {

   
    uint256 public  value;
    
    function setValue(uint256 newvalue) public payable {
         value = newvalue*newvalue;
    }

     

}
