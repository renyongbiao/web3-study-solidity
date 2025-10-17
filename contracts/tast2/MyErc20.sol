// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/interfaces/IERC20.sol";

/**
 * @title SimpleToken
 * @dev   纯手工实现 IERC20，带 owner 铸币权限
 */
contract SimpleToken is IERC20 {
    
    uint256 public override totalSupply;          // 总供应量
    mapping(address => uint256) public override balanceOf;
    mapping(address => mapping(address => uint256)) public override allowance;

    string  public name     = "SimpleToken";
    string  public symbol   = "ST";
    uint8   public decimals = 18;                 

    address private immutable owner;

    /* ====== 构造函数 ====== */
    constructor() {
        owner = msg.sender;
    }

    /* ====== IERC20 标准函数 ====== */
    function transfer(address to, uint256 amount)
        external
        override
        returns (bool)
    {
        require(to != address(0), "Zero address");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");

        unchecked {
            balanceOf[msg.sender] -= amount;
            balanceOf[to]         += amount;
        }
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount)
        external
        override
        returns (bool)
    {
        require(spender != address(0), "Zero address");

        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount)
        external
        override
        returns (bool)
    {
        require(from != address(0) && to != address(0), "Zero address");
        require(balanceOf[from] >= amount, "Insufficient balance");
        require(allowance[from][msg.sender] >= amount, "Allowance exceeded");

        unchecked {
            balanceOf[from]             -= amount;
            balanceOf[to]               += amount;
            allowance[from][msg.sender] -= amount;
        }
        emit Transfer(from, to, amount);
        return true;
    }

    // 铸币（仅 owner）
    function mint(address to, uint256 amount) external returns (bool) {
        require(msg.sender == owner, "Unauthorized");
        require(to != address(0), "Zero address");

        totalSupply += amount;
        balanceOf[to] += amount;

        emit Transfer(address(0), to, amount);
        return true;
    }
}
