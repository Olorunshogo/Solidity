// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract AuctionContract {

uint public auctionCounter;

    enum AuctionStatus{
        Pending,
        OnGoing,
        Completed,
        Cancelled
    }

    struct Auction{
        uint id;
        uint startingPrice;
        AuctionStatus status;
        address owner;
        address highestBidder;
        uint startTime;
        uint duration;

    }

    mapping (uint => Auction) public auctions;

    event AuctionInitialaized(uint id);



    constructor() {

    }

    function createAuction(uint _price, uint _duration) public returns(uint){
        require(_price > 0, 'non zero price');
        require(_duration > 600, 'minimum 10mins for auction time');

        auctionCounter++;
        Auction memory a =  Auction(auctionCounter, _price, AuctionStatus.Pending, msg.sender, address(0), 0, _duration);

        auctions[auctionCounter] = a;
        emit AuctionInitialaized(auctionCounter);

        return auctionCounter;
    }

    function startAuction(uint _auctionsId) public {
        Auction storage a =  auctions[_auctionsId];

        require(msg.sender == a.owner, "Not your Auction");
        require(a.status == AuctionStatus.Pending, 'invalid auction Status');

        a.status = AuctionStatus.OnGoing;
        a.startTime = block.timestamp;
    }

function bid(uint auction_id) external payable returns(bool){

}

function returnBalances(address person) external view returns(uint){
    uint bal = address(person).balance;

    return bal;
}

}

