

# Tests
+ Deployment
  - Tests for all during deployments
+ Transactions
  - inc()
  - incBy()
  - decrease()
+ Events


```solidity

it("Owner can revoke access", async function () {
  await counter.grantAccess(user1.address);
  await counter.revokeAccess(user1.address);

  expect(await counter.authorized(user1.address)).to.equal(false);
});

it("Non-owner cannot revoke access", async function () {
  await expect(
    counter.connect(user1).revokeAccess(user2.address)
  ).to.be.revertedWith("Not the owner");
});

```
