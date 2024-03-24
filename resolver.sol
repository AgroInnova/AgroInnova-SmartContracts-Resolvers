// SPDX-License-Identifier: MIT
//0x5A6B0aD245E84cbd3fd70f5e49438a6093f48c54
pragma solidity 0.8.24;
import { IEAS, AttestationRequest,Attestation} from "@ethereum-attestation-service/eas-contracts/contracts/IEAS.sol";
import { SchemaResolver } from "@ethereum-attestation-service/eas-contracts/contracts/resolver/SchemaResolver.sol";


/// @title AttesterResolver
/// @notice A sample schema resolver that checks whether the attestation is from a specific attester.
contract AttesterResolver is SchemaResolver {
    address private immutable _targetAttester;

    constructor(IEAS eas, address targetAttester) SchemaResolver(eas) {
        _targetAttester = targetAttester;
    }

    function onAttest(Attestation calldata attestation, uint256 /*value*/) internal view override returns (bool) {
        return attestation.attester == _targetAttester;
    }

    function onRevoke(Attestation calldata /*attestation*/, uint256 /*value*/) internal pure override returns (bool) {
        return true;
    }
}