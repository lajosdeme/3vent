// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "./Identity.sol";
import "./Soul.sol";

/**
 * @dev The Identity Factory contract is used to create new identities and souls.
 */
contract IdentityFactory is Ownable {
    /** @dev Addresses of the master implementations for identity and soul. */
    address public masterIdentity;
    address public masterSoul;

    /** @dev Mapping from owner address to identity contract address. */
    mapping(address => Identity) public identities;
    /** @dev Mapping from owner address to soul contract address. */
    mapping(address => Soul) public souls;

    /* Events */
    event IdentityCreated(address indexed creator, address indexed identity);
    event SoulCreated(address indexed creator, address indexed soul);

    /* Modifiters */
    modifier identityDoesNotExist() {
        require(address(identities[msg.sender]) == address(0), "IdentityFactory: Address already has an identity.");
        _;
    }

    modifier soulDoesNotExist() {
        require(address(souls[msg.sender]) == address(0), "IdentityFactory: Address is already a Soul.");
        _;
    }

    constructor(address _masterIdentity, address _mastersoul) {
        require(_masterIdentity != address(0), "Master identity has to be a valid address.");
        require(_mastersoul != address(0), "Master Soul has to be a valid address.");

        masterIdentity = _masterIdentity;
        masterSoul = _mastersoul;
    }

    /** 
     * @dev Changes the address of the master identity contract.
     * @param _masterIdentity The new master identity contract address.
     */
    function setMasterIdentity(address _masterIdentity) external onlyOwner {
        require(_masterIdentity != address(0), "IdentityFactory: Master identity has to be a valid address.");
        masterIdentity = _masterIdentity;
    }

    /**
     * @dev Changes the address of the master soul contract.
     * @param _masterSoul The new master soul contract address.
     */
    function setMasterSoul(address _masterSoul) external onlyOwner {
        require(_masterSoul != address(0), "IdentityFactory: Master Soul has to be a valid address.");
        masterSoul = _masterSoul;
    }

    /**
     * @dev Creates a new identity. The owner of the identity will be msg.sender.
     * @param profileInfo An arbitrary bytes representing the profile info of the identity.
     */
    function createIdentity(bytes calldata profileInfo) external identityDoesNotExist {

        Identity _identity = Identity(Clones.clone(masterIdentity));

        _identity.initialize(msg.sender, profileInfo);

        identities[msg.sender] = _identity;

        emit IdentityCreated(msg.sender, address(_identity));
    }

    /**
     * @dev Creates a new soul. The owner of the soul will be msg.sender.
     * @param profileInfo An arbitrary bytes representing the profile info of the profileInfo.
     * @param _name The name of the soulbound token that belongs to this soul.
     * @param _symbol The symbol of the soulbound token that belongs to this soul.
     */
    function createSoul(bytes calldata profileInfo, string memory _name, string memory _symbol) external soulDoesNotExist {
        Soul _soul = Soul(Clones.clone(masterSoul));

        _soul.initialize(msg.sender, profileInfo, _name, _symbol);

        souls[msg.sender] = _soul;

        emit SoulCreated(msg.sender, address(_soul));
    }
}