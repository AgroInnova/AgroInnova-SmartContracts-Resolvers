// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import { IEAS, AttestationRequest, AttestationRequestData, RevocationRequest, RevocationRequestData } from "@ethereum-attestation-service/eas-contracts/contracts/IEAS.sol";
import { NO_EXPIRATION_TIME, EMPTY_UID } from "@ethereum-attestation-service/eas-contracts/contracts/Common.sol";

/// @title Attester
/// @notice Ethereum Attestation Service - Example
contract Attester {
    error InvalidEAS();

    // The address of the global EAS contract.
    IEAS private immutable _eas;
    address private immutable _targetRecipient;

    /// @notice Creates a new Attester instance.
    /// @param eas The address of the global EAS contract.
    constructor(IEAS eas, address targetRecipient) {
        if (address(eas) == address(0)) {
            revert InvalidEAS();
        }

        _eas = eas;
        _targetRecipient = targetRecipient;
        
    }


    function attest(bytes32 _schema, string memory _userId, uint32 _equipmentId, uint64 _activationDays) public  returns (bytes32) {
        return
            _eas.attest(
                AttestationRequest({
                    schema: _schema,
                    data: AttestationRequestData({
                        recipient: _targetRecipient, 
                        expirationTime: _activationDays,
                        revocable: true,
                        refUID: EMPTY_UID, // No references UI
                        data: abi.encode(_userId,_equipmentId,_activationDays), 
                        value: 0 // No value/ETH
                    })
                })
            );
    }

    /// @notice Revokes an attestation of a schema that receives a uint256 parameter.
    /// @param schema The schema UID to attest to.
    /// @param uid The UID of the attestation to revoke.
    function revoke(bytes32 schema, bytes32 uid) public {
        _eas.revoke(RevocationRequest({ schema: schema, data: RevocationRequestData({ uid: uid, value: 0 }) }));
    }
}