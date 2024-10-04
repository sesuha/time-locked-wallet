// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract TimeLockedWallet {
    address public owner;
    uint public unlockTime;

    constructor(address _owner, uint _unlockTime) {
        owner = _owner;
        unlockTime = _unlockTime;
    }

    receive() external payable {}

    function withdraw() external {
        require(block.timestamp >= unlockTime, "Funds are locked");
        require(msg.sender == owner, "Only the owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
