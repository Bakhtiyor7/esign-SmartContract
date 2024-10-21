// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DigitalSignature {
    // Event emitted when a document is signed
    event DocumentSigned(address indexed signer, bytes32 indexed documentHash, uint256 timestamp);

    // Mapping of document hash to signer address and timestamp
    struct Document {
        address signer; 
        uint256 timestamp;
    }

    mapping(bytes32 => Document) public documents;

    /**
     * @dev Sign a document by providing its hash.
     * @param _documentHash The hash of the document to be signed.
     */
    function signDocument(bytes32 _documentHash) public {
        require(_documentHash != 0, "Invalid document hash");
        require(documents[_documentHash].timestamp == 0, "Document already signed");

        documents[_documentHash] = Document({
            signer: msg.sender,
            timestamp: block.timestamp
        });

        emit DocumentSigned(msg.sender, _documentHash, block.timestamp);
    }

    /**
     * @dev Verify if a document is signed and retrieve signer information.
     * @param _documentHash The hash of the document to verify.
     * @return signer The address of the signer.
     * @return timestamp The timestamp when the document was signed.
     */
    function verifyDocument(bytes32 _documentHash) public view returns (address signer, uint256 timestamp) {
        require(documents[_documentHash].timestamp != 0, "Document not signed");

        Document memory doc = documents[_documentHash];
        return (doc.signer, doc.timestamp);
    }
}
