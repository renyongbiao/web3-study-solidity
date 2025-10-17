// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721URIStorage,Ownable {

   uint256 private tokenCounter;


    constructor (string memory name,string memory symbol) ERC721(name,symbol)  Ownable(msg.sender) {
        tokenCounter = 1;
    }

    function mintNFT(address  a, string memory tokenURI ) external  returns (uint256) {

        uint256 newTokenID = tokenCounter;
        _mint(a, newTokenID);
        _setTokenURI(newTokenID,tokenURI);

        tokenCounter++;

        return newTokenID;

    }




}