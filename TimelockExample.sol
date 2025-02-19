1
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/governance/TimelockController.sol";


/*
限定访问范围：
使用 external 修饰的函数只能通过外部调用来触发，比如其他合约或外部账户调用。这有助于控制函数的使用场景，防止合约内部误用。

节省 Gas：
当外部调用 external 函数时，参数通常直接存储在调用数据（calldata）中，不会被复制到内存（memory），从而降低 Gas 消耗。

适合接口函数：
通常用在合约对外暴露的接口上（比如 DApp 的 API），因为这些函数只需要被外部调用，不需要在合约内部多次调用。

修饰符	内部可调用	外部可调用	使用场景
public	可以直接调用	可以直接调用	既对内也对外开放的函数
external	不能直接调用（除非通过 this.func()）	可以直接调用	只暴露给外部调用，节省 Gas
internal	只能在合约内部调用（或继承的子合约）	不能调用	辅助函数，或仅在合约内部使用
private	只能在当前合约调用	不能调用	限制在合约内部，不对继承的子合约暴露


特性	calldata （调用数据区域）	memory （临时存储）	storage （持久存储）
可读/可写	只读	可读可写	可读可写
生命周期	仅限函数调用期间	仅限函数调用期间	持久存储（存储在区块链上）
Gas 成本	低（最省 Gas）	中等（比 calldata 更贵）	高（因为涉及链上存储）
适用数据	动态数组、字符串、结构体	动态数组、字符串、结构体	所有类型
作用范围	external 函数的参数	函数内部变量	合约全局变量

*/

contract TimelockExample is TimelockController,Ownable{

     address public targetAddress;  // 目标地址，用于演示资金转账操作

    constructor(
        uint256 minDelay,
        address[] memory proposers,
        address[] memory executors
    )   TimelockController(minDelay, proposers, executors,msg.sender) 
        Ownable(msg.sender)
    {}

    // 示例：安排一个转账操作
    function scheduleTransfer(
        address target,    // 目标合约地址
        bytes32 salt,       // 随机盐值
        bytes calldata mdata
    ) public {
        // 构造调用数据
        // 计算操作ID
        

        //bytes32 operationAId = hashOperation(targetA, valueA, dataA, bytes32(0), saltA);

        bytes32 id = hashOperation(
            target,
            0,          // value
            mdata,
            bytes32(0),
            salt
        );

        // 检查是否已存在相同操作
        require(!isOperation(id), "Operation already scheduled");

        // 安排操作（需要PROPOSER角色）
        schedule(
            target,
            0,              // value
            mdata,
            bytes32(0),    // predecessor
            salt,
            getMinDelay()   // 使用最小延迟
        );
    }

    // 示例：执行操作（需要EXECUTOR角色）
    function executeTransfer(
        address target,
        bytes32 salt,       // 随机盐值
        bytes calldata mdata
    ) public {

        execute(
            target,
            0,
            mdata,
            bytes32(0),
            salt
        );
    }


}
