// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";

contract CreatureHome is ERC721, ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter;
    mapping(address=>uint) public maxMint;
    uint MAX_SUPPLY = 100;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Creature Home", "CRH") {}

    function safeMint(address to, string memory uri) public {
       
        uint256 tokenId = _tokenIdCounter.current();
        require(tokenId<=MAX_SUPPLY);
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
         maxMint[to] = tokenId;
        require(maxMint[to]<=4 , "You allowed only 5 NFT Maximum for Minting. SORRY ! You can use Another account");
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
