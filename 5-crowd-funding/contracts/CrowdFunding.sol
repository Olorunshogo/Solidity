// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract CrowdFunding {
    address public owner;
    uint public fundingGoal;
    uint public deadline;
    uint public totalRaised;

    enum Status {
      NOT_STARTED,
      ACTIVE,
      SUCCESSFUL,
      FAILED
    }

    Status public vaultStatus;

    mapping(address => uint) public contributions;

    event Log(address indexed user, string message);
    event Contributed(address indexed user, uint amount);
    event Withdrawn(address indexed owner, uint amount);
    event Refunded(address indexed user, uint amount);

    constructor(uint _fundingGoal, uint _duration) {
        owner = msg.sender;
        fundingGoal = _fundingGoal;
        deadline = block.timestamp + _duration;
        vaultStatus = Status.ACTIVE;
    }

    // Users contribute ETH
    function contribute() external payable {
        require(vaultStatus == Status.ACTIVE, "Funding not active");
        require(block.timestamp < deadline, "Deadline passed");
        require(msg.value > 0, "Must send ETH");

        contributions[msg.sender] += msg.value;
        totalRaised += msg.value;

        emit Contributed(msg.sender, msg.value);

        if (totalRaised >= fundingGoal) {
            vaultStatus = Status.SUCCESSFUL;
            emit Log(msg.sender, "Funding goal reached");
        }
    }

    // Owner withdraws if goal met
    function withdrawFunds() external {
        require(msg.sender == owner, "Only owner");
        require(vaultStatus == Status.SUCCESSFUL, "Goal not met");

        uint balance = address(this).balance;
        vaultStatus = Status.NOT_STARTED;

        (bool success, ) = owner.call{value: balance}("");
        require(success, "Transfer failed");

        emit Withdrawn(owner, balance);
    }

    // Contributors claim refund if goal not met
    function claimRefund() external {
        require(block.timestamp >= deadline, "Deadline not reached");
        require(vaultStatus != Status.SUCCESSFUL, "Goal was met");

        uint amount = contributions[msg.sender];
        require(amount > 0, "No contribution");

        contributions[msg.sender] = 0; // prevents double refund
        vaultStatus = Status.FAILED;

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Refund failed");

        emit Refunded(msg.sender, amount);
    }
}
