// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ERC20 {
  string public name;
  string public symbol;
  string public decimals;

  uint private _totalSupply;

  mapping (address => uint256) private _balances;
  mapping (address => mapping (address => uint)) private _allowances;

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);

  constructor(
    string memory _name,
    string memory _symbol,
    string memory _decimals
  ) {
    name = _name;
    symbol = _symbol;
    decimals = _decimals;
    // Mint tokens to contract creator
  }

  // Total Supply
  function totalSupply() external view returns (uint256) {
    return _totalSupply;
  }

  // Total balance
  function balanceOf(address account) external view returns (uint256) {
    return _balances[account];
  }

  // Allowances
  function allowance(address owner, address spender) external view returns (uint256) {
    return _allowances[owner][spender];
  }

  // Transfer
  function transfer(address from, address to, uint amount) internal {
    // Verify that it's not address zero calling
    require(to != address(0), "Transfer to zero address");

    uint256 senderBalance = _balances[from];
    require(senderBalance >= amount, "Insufficient funds");

    unchecked{
      _balances[from] = senderBalance - amount;
      _balances[to] += amount;
    }
  }

}
