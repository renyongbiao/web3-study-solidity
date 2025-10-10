// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Voting {

    uint32 public item ;
    // 定义候选人和得票的map
    mapping (uint32 => mapping (address  => uint32 )) public votesOfcandidate;
    // 合约发布者
    address  public  owner;

    constructor(){
        owner = msg.sender;
        item += 1;
    }

   // 投票给某个用户地址
    function vote(address a) public {
        votesOfcandidate[item][a] +=1;

    }

    // 查询某个用户的得票
    function getVotes(address a) public view returns(uint32){
        return  votesOfcandidate[item][a];
    }

        // 重置所有用户的得票
    function resetVotes() public{

       // 必须合约拥有者才有权限重置
       require(owner==msg.sender,"only owner can be reset!");
        item += 1;
    }
}