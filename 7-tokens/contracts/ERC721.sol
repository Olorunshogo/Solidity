// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// === ERC165 Interface ===
interface IERC165 {
  function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

// === ERC721 Interface inheriting IERC165 ===
interface IERC721 is IERC165 {
  event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
  event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
  event ApprovalForAll(address indexed owner, address indexed operator, bool tokenId);

  function balanceOf(address owner) external view returns (uint256);
  function ownerOf(uint256 tokenId) external view returns (address);

  function safeTransferFrom(address from, address to, uint256 tokenId) external;
  function safeTransferFrom (address from, address to, uint256 tokenId, bytes calldata data) external;

  function transferFrom(address from, address to, uint256 _tokenId) external payable;

  function approve(address to, uint256 tokenId) external payable;
  function setApprovalForAll(address operator, bool approved) external;

  function getApproved(uint256 tokenId) external view returns (address);
  function isApprovedForAll(address owner, address operator) external view returns (bool);

}

// === ERC721Metadata Interface inheriting IERC721 ===
interface IERC721Metadata is IERC721 {
  function name() external view returns (string memory);
  function symbol() external view returns (string memory);
  function tokenURI(uint256 _tokenId) external view returns (string memory);
}

// === ERC721Metadata Interface inheriting IERC721 ===
interface IERC721Receiver {
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4);
}

abstract contract ERC721 is IERC721Metadata {
  string private _name;
  string private _symbol;
  string private _baseURI;

  mapping(uint => address) private _owners;
  mapping(address => uint256) private _balances;

  mapping(uint256 => address) private _tokenApprovals;

  // Passing in owner address and in the spender address, give the approval status of the spender
  mapping(address => mapping(address => bool)) private _operatorApprovals;

  constructor(string memory name_, string memory symbol_, string memory baseURI_) {
    _name = name_;
    _symbol = symbol_;
    _baseURI = baseURI_;
  }

  function supportInterface(bytes4 interfaceId) external pure returns (bool) {
    return interfaceId == 0x01ffc9a7 || // IERC 165
        interfaceId == 0x80ac || // IERC721
        interfaceId == 0x5b5e139f; // IERC721Metadata
  }

  function name() external view returns (string memory) {
    return _name;
  }

  function symbol() external view returns (string memory) {
    return _symbol;
  }

  function balanceOf(address owner) public view returns (uint256) {
    require(owner != address(0), "Real address");

    return _balances[owner];
  }

  function ownerOf(uint256 tokenId) external view returns (address) {
    address owner = _owners[tokenId];
    require(owner != address(0), "Zero address");
    return owner;
  }

  function _exists(uint256 tokenId) internal view returns (bool) {
    return _owners[tokenId] != address(0);
  }

  function tokenURI(uint256 tokenId) external view returns (string memory) {
    require(_exists(tokenId), "Invalid token");
    if(bytes(_baseURI).length == 0) return "";
    return string(abi.encodePacked(_baseURI, tokenId));
  }

}

