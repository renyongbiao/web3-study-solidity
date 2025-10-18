// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/access/Ownable.sol";


contract BeggingContract is Ownable {
    // 记录每个地址累计捐赠额
    mapping(address => uint256) public donateUsers;

    constructor() Ownable(msg.sender) {}

    function donate() external payable {
        require(msg.value > 0, "give me some ETH");
        donateUsers[msg.sender] += msg.value;
    }

    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "nothing to withdraw");

        (bool ok, ) = payable(owner()).call{value: balance}("");
        require(ok, "transfer failed");
    }

    function getDonation(address user) external view returns (uint256) {
        return donateUsers[user];
    }


}




