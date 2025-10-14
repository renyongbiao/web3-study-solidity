// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
import "@openzeppelin/contracts/interfaces/IERC20.sol";

// 直接实现openzepplin的IERC20接口
contract MyErc20 is IERC20{


    // 代币总量
    uint256 public totalSupply;
    // 记录代币余额
    mapping (address => uint256) public balanceOf;
    // 记录A授权给B代币额度
    mapping (address => mapping (address => uint256)) public _balance;
    // 合约创建人
    address private  owner;

    // 构造函数
    constructor() {
        owner = msg.sender;
    }

    // 查询剩余授权额度 
    function allowance(address _owner, address spender) external view override returns (uint256){

        return _balance[_owner][spender];

    }

    // 授权 spender 可动用 amount 
     function approve(address spender, uint256 value) external override  returns (bool){
        require(balanceOf[msg.sender]>=value,"Insufficient balance"); // 余额校验
        require(spender != address(0), "this address unexit"); // 目标地址校验

        _balance[msg.sender][spender] = value; //记录授权额度
        emit Approval(msg.sender, spender, value); //记录事件

        return  true;
    }



    // 调用者直接转账 
     function transfer(address to, uint256 value) external override returns (bool){
        require(balanceOf[msg.sender]>=value,"Insufficient balance"); // 余额校验
        require(to != address(0), "this address unexit"); // 目标地址校验

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value); //记录事件

        return true;


     }

    // sender 代 from 转账给 to（需预授权） 
     function transferFrom(address from, address to, uint256 value) external override returns (bool){
        require(balanceOf[from]>=value,"Insufficient balance"); // 转出账户余额大于转账金额
        require(_balance[from][msg.sender]>=value,"Insufficient balance"); //授权余额需要大于转账金额

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value); //记录事件

        return true;

     }

     // mint 铸造代币
     function mint(address to,uint256 amount) external returns (uint256) {
        require(msg.sender == owner,"must owner can be mint!");
        require(to != address(0), "this address unexit");

        totalSupply += amount;
        balanceOf[to] += amount;  

        emit Transfer(address(0), to, amount);
        return totalSupply;
     }


}