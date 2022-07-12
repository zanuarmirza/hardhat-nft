//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFTMint is ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;

    string public BASE_URI;
    uint256 public MAX_SUPPLY = 5;
    uint256 public PRICE = 0;

    constructor(
        string memory baseURI,
        uint256 price, 
        string memory name,
        string memory symbol
    ) ERC721(name, symbol) {
        PRICE = price;
        BASE_URI = baseURI;
    }

    function _baseURI() internal view override returns (string memory) {
        return string(abi.encodePacked(BASE_URI, "/"));
    }

    function mint(address addr)
        public
        payable
        returns (uint256)
    {
        uint256 supply = totalSupply();
        require(supply <= MAX_SUPPLY, "Would exceed max supply");    
        require(msg.value >= PRICE, "insufficient funds");
        uint256 tokenId = supply + 1;       
        _safeMint(addr, tokenId);
    
        return tokenId;
    }
}