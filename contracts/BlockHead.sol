// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BlockHead is ERC721, ERC721Enumerable, Ownable {
    constructor() ERC721("BlockHead", "BH") {}

    uint256 tokenId = 1;

    struct Attr {
        string name;
        string headType;
        string headColor;
        string bodyColor;
        string backgroundColor;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 _tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, _tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function mint() public payable {
        require(tokenId <= 111, "sold out");
        _safeMint(msg.sender, tokenId++);
    }

    /**
     * @dev Returns an URI for a given token ID
     */
    function tokenURI(uint256 _tokenId)
        public
        pure
        override(ERC721)
        returns (string memory)
    {
        // return
        //     "bafybeibotgk3nnwcv5l44qzypseiganetlyirezietqorbqknc2w3vj3si.ipfs.dweb.link/";
        return
            Concatenate(
                Concatenate(
                    "https://bafybeiekc53cbdgwr2mpox6vys3soef4kfcgbynbgcyuqagpd4xt5w3jlq.ipfs.dweb.link/",
                    UintToString(_tokenId)
                ),
                ".json"
            );
    }

    function test() external pure returns (string memory) {
        return "test";
    }

    function Concatenate(string memory a, string memory b)
        public
        pure
        returns (string memory concatenatedString)
    {
        bytes memory bytesA = bytes(a);
        bytes memory bytesB = bytes(b);
        string memory concatenatedAB = new string(
            bytesA.length + bytesB.length
        );
        bytes memory bytesAB = bytes(concatenatedAB);
        uint256 concatendatedIndex = 0;
        uint256 index = 0;
        for (index = 0; index < bytesA.length; index++) {
            bytesAB[concatendatedIndex++] = bytesA[index];
        }
        for (index = 0; index < bytesB.length; index++) {
            bytesAB[concatendatedIndex++] = bytesB[index];
        }

        return string(bytesAB);
    }

    function UintToString(uint256 _i)
        public
        pure
        returns (string memory uintAsString)
    {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}

// contract BlockHead is ERC721 {
//     address public owner;
//     uint256 tokenId = 1;
//     uint256 mintPrice = 0.1 ether;
//     uint256 totalSupply = 0;
//     uint256 maxSupply = 111;
//     uint256 maxPerWallet = 10;

//     struct Block {
//         uint256 tokenId;
//         string tokenName;
//         address owner;
//     }

//     Block[] public allTokens;

//     mapping(address => uint256) public walletMints;

//     constructor() ERC721("BlockHead", "BH") {
//         owner = msg.sender;
//     }

//     function getAllTokens() public view returns (Block[] memory) {
//         return allTokens;
//     }

//     function mint(uint256 _quantity) public payable {
//         require(msg.value == _quantity * mintPrice, "wrong mint value");
//         require(totalSupply + _quantity <= maxSupply, "max supply exceeded");
//         require(
//             walletMints[msg.sender] + _quantity <= maxPerWallet,
//             "exceeded mint for this wallet"
//         );

//         for (uint256 i = 0; i < _quantity; i++) {
//             uint256 newTokenId = totalSupply++;
//             _safeMint(msg.sender, newTokenId);
//             walletMints[msg.sender]++;
//             allTokens.push(Block(newTokenId, "Block Head", msg.sender));
//         }
//     }
// }
