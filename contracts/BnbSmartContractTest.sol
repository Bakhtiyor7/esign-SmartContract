// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DocumentSigner {
    struct Document {
        address sender;
        bytes32 hash;
        string signature;
        uint256 timestamp;
    }

    mapping(bytes32 => Document) private documents;

    event DocumentSigned(bytes32 indexed hash, address indexed sender, uint256 timestamp, string signature);

    // Function to store the document hash
    function signDocument(bytes32 _hash, string memory _signature) public {
        require(documents[_hash].sender == address(0), "Document already signed");
        documents[_hash] = Document({
            sender: msg.sender,
            hash: _hash,
            signature: _signature,
            timestamp: block.timestamp
        });
        emit DocumentSigned(_hash, msg.sender, block.timestamp, _signature);
    }

    // Function to retrieve the document details by hash
    function getDocument(bytes32 _hash) public view returns (address sender, string memory signature) {
        require(documents[_hash].sender != address(0), "Document not found");
        Document memory doc = documents[_hash];
        return (doc.sender, doc.signature);
    }

    // Function to check if a document hash exists
    function documentExists(bytes32 _hash) public view returns (bool) {
        return documents[_hash].sender != address(0);
    }
}
