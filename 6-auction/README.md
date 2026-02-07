# Auction Setup
The highest bidder wins when the auction ends.

Functional Requirements
1. Auction Setup
Owner sets:
startingPrice
auctionDuration

Auction starts immediately on deployment

2. Bidding
Anyone can bid by sending ETH
Bid must be higher than current highest bid
Previous highest bidder&apos;s ETH must be refundable

3. Ending the Auction
Auction ends after duration expires
Only owner can end the auction
Highest bidder wins
Owner receives the highest bid

4. Refunds
Outbid users must be able to withdraw their funds
No automatic refunds during bidding


## Edge Cases to Handle
1. Bid after auction ends
2. Bid equal to highest bid
3. Ending auction twice
4. Owner bidding on own auction

