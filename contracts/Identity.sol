// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./ERC725/ERC725Init.sol";

/** 
 * @dev Identity contract implementation inheriting from ERC725. 
 * @notice Deployed through a factory contract, the owner of the Identity contract will be 
 * the address calling the deploy function in the factory.
 */
contract Identity is ERC725Init { 

    /* The key where the profile info of the identity's owner will be stored at. */
    bytes32 public PROFILE_IDENTIFIER;

    /** 
     * @dev Initializes the identity contract. 
     * @param newOwner The owner of the identity.
     * @param profileInfo Arbitrary data that represents the user's profile info. 
     * Can be actual profile data encoded into bytes or a reference to an IPFS location storing the profile data. 
     */
    function initialize(address newOwner, bytes calldata profileInfo) public {
        PROFILE_IDENTIFIER = keccak256("Profile");
        _setData(PROFILE_IDENTIFIER, profileInfo);
        super.initialize(newOwner);
    }
}