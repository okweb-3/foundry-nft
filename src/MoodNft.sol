//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import { Base64 } from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";


contract MoodNft is ERC721 {
    string private s_sadSvgImgUri;
    string private s_happySvgImgUri;
    uint256 private s_tokenCounter;
    enum Mood {
        HAPPY,
        SAD
    }
    mapping (uint256 => Mood) private s_tokenIdToMood;
    constructor(string memory sadSvg, string memory happySvg) ERC721 ("Mood NFT","MN") {
        s_tokenCounter  = 0;
        s_sadSvgImgUri = sadSvg;
        s_happySvgImgUri = happySvg;
    }
    function mintNft()public{
        _safeMint(msg.sender,s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }
    function tokenURI(uint256 tokenId)public view override  returns (string memory) {
        string memory imageURI;
        if(s_tokenIdToMood[tokenId] == Mood.HAPPY){
            imageURI = s_happySvgImgUri;
        }else {
            imageURI = s_sadSvgImgUri;

        }
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                        '{"name: "',
                        name(),
                        '", description: "An NFT that reflects your mood!", "attributes": [{"trait_type": "Mood", "value": 100}], "image": ',
                        imageURI,
                        '"}'
                        )
                    )
                )
            )
        );
    }
    
}

