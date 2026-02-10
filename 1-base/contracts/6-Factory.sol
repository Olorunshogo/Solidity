// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./6-Auction.sol";

contract AuctionFactory {

    uint256 public auctionCount;
    mapping(uint256 => address) public auctions;

    event AuctionCreated(uint256 indexed id, address auction, address owner);

    function createAuction( uint256 startingPrice, uint256 auctionDuration ) external returns (address) {
        Auction auction = new Auction(
            startingPrice,
            auctionDuration
        );

        auctions[auctionCount] = address(auction);

        emit AuctionCreated(auctionCount, address(auction), msg.sender);

        auctionCount++;
        return address(auction);
    }
}
