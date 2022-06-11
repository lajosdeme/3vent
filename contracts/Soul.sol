// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./Identity.sol";
import "./SBT/SBT.sol";

/**
 * @dev Soul contract that can mint Soulbound tokens.
 */
contract Soul is Identity {
    /** @dev Soulbound token that belongs to this Soul. */
    SBT public sbt;

    /** 
     * @dev Initializes a new Soul.
     * @param newOwner The owner of the soul.
     * @param profileInfo An arbitrary bytes that represents the profile info for the soul. 
     * It can be an IPFS hash for example.
     * @param _name The name of the Soulbound Token.
     * @param _symbol The symbol of the souldbound token.
    */
    function initialize(address newOwner, bytes calldata profileInfo, string memory _name, string memory _symbol) public {
        sbt = new SBT(_name, _symbol);
        super.initialize(newOwner, profileInfo);
    }

    /**
     * @dev Mints a soulbound token to `to`.
    */
    function mintSBT(address to) external onlyOwner {
        uint256 _tokenId = sbt.totalSupply();
        sbt.mint(to, _tokenId);
    }
}