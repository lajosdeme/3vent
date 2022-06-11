
The Identity Factory is a suite of smart contracts that together make a complete blockchain based identity solution.
Through the factory individuals can create identities for themselves, while event organizers/institutions etc. can create Souls, that are able to issue soulbound tokens (SBT) to the identity contracts.

## Architecture

![3vent-contracts](https://user-images.githubusercontent.com/44027725/173203283-f45dbd28-f522-4c39-b465-5c1d7697a3b7.jpg)

## Identity

The `Identity.sol` contract is an `ERC725` contract that is able to hold SBTs, and can contain any information about the identity.
We are using the `setData` function of `ERC725` to store some arbitrary bytes that represent the profile information of the identity. This can be an IPFS hash that refers to a JSON file for example. This profile data is stored under the key `PROFILE_IDENTIFIER` which is set to `keccak256("Profile")`.

## Soul
The `Soul.sol` contract is an `Identity` that owns an SBT an has minting capability. Upon the initialization of the contract an SBT contract is deployed and th e `Soul` is set as it's owner.

## SBT

Implementation of a soulbound token. Soulbound tokens are non-transferrable, non-financializable tokens proposed by Vitalik Buterin. Our implementation shares most of its functionality with the ERC721 standard, except that the `transfer` functions are taken out, thereby making the SBTs non-transferrable.

## Identity Factory

Contract for deploying identities and souls. It relies on the `Clones` library from OpenZeppelin to create many instances of the same contract. An important limitation is that only one identity and soul can be created per wallet.
