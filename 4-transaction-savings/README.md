# Transaction Savings

Timelocked Savings Vault

Objective
Create a Timelocked Savings Vault where users can lock ETH and only withdraw it after a specified time.

Each user can have only one active vault at a time.

Functional Requirements
1. Deposit

    - User deposits ETH and specifies:

    - unlockTime (future timestamp)

    - ETH must be greater than zero

    - Deposit locks the vault

2. Withdrawal

    - User can withdraw only after block.timestamp >= unlockTime

    - Full balance must be withdrawn at once

    - Vault resets after withdrawal

3. Restrictions

    - User cannot deposit again if a vault is active

    - Contract must reject direct ETH transfers

    - No one can withdraw another user&apos;s funds

    - Edge Cases to Handle

    - User sets unlock time in the past

    - User tries to withdraw early

    - User tries to deposit twice

    - User withdraws twice
