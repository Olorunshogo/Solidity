// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Auction {
    address public owner;
    uint256 public startingPrice;
    uint256 public auctionDuration;

    address public highestBidder;
    uint256 public highestBid;

    bool public ended;

    mapping(address => uint256) public refunds;

    event BidPlaced(address indexed bidder, uint256 amount);
    event AuctionEnded(address winner, uint256 amount);
    event RefundWithdrawn(address indexed bidder, uint256 amount);

    // modifier onlyOwner() {
    //     require(msg.sender == owner, "Only bidder can bid");
    //     _;
    // }

    modifier activeAuction() {
        require(block.timestamp < auctionDuration, "Auction ended");
        _;
    }

    // With factory
    constructor(uint _startingPrice, uint _auctionDuration) {
        // Where are my require's in my constructors!!!
        owner = msg.sender;
        startingPrice = _startingPrice;
        auctionDuration = block.timestamp + _auctionDuration;
        highestBid = _startingPrice;
    }

    function bid() external payable activeAuction {
        require(msg.sender != owner, "Owner cannot bid");
        require(msg.value > highestBid, "Bid too low");
        require(msg.value > 0, "Too small. Must send ETH > 0");
        require(block.timestamp < auctionDuration, "Auction has ended");

        // Save refund for previous highest bidder
        // I need to have a one to many mapping, mapping an address to refund list, use the concept of a pending return.
        // Use struct for highestBidder
        if (highestBidder != address(0)) {
            refunds[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;

        emit BidPlaced(msg.sender, msg.value);
    }

        // Without factory
        // function endAuction() external onlyOwner {
        // With factory
        function endAuction() external {
            require(block.timestamp <= auctionDuration, "Auction still active");
            require(!ended, "Auction already ended");

            ended = true;

            if (highestBidder != address(0)) {
                (bool success, ) = owner.call{value: highestBid}("");
                require(success, "Transfer failed");
            }

            emit AuctionEnded(highestBidder, highestBid);
    }

    function withdrawRefund() external {
        uint256 amount = refunds[msg.sender];
        require(amount > 0, "No refund available");

        refunds[msg.sender] = 0;

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Refund failed");

        emit RefundWithdrawn(msg.sender, amount);
    }

}
