//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";



contract BasicNft is ERC721{
    //Doogie ->NFT name
    //Dog    -> NFT symbol
    //Token counter
    
    uint256 private s_tokenCounter = 0;
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor() ERC721 ("Doogie","DOG"){
        s_tokenCounter = 0;
    }
    function mintNft(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender,s_tokenCounter);
        s_tokenCounter++;
    }
    
    function tokenURI(uint256 tokenId)public view override returns(string memory){
        return s_tokenIdToUri[tokenId];
    }
}
