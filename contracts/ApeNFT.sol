pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ApeNFT is ERC1155, AccessControl, Ownable {
    bytes32 public constant ROLE_ADMIN = keccak256("ROLE_ADMIN");
    uint256 public nextTokenId;
    uint256 public totalSupply;
    mapping(uint256 => string) tokenURIs;

    modifier onlyAdmin {
        require(hasRole(ROLE_ADMIN, msg.sender), "Sender is not admin");
        _;
    }

    /**
     * @dev Allows users with the admin role to
     * grant/revoke the admin role from other users

     * Params:
     * _admin: address of the first admin
     */
    constructor(address _admin) ERC1155("") {
        _setupRole(ROLE_ADMIN, _admin);
        _setRoleAdmin(ROLE_ADMIN, ROLE_ADMIN);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC1155, AccessControl)
        returns (bool)
    {
        return
            interfaceId == type(IERC1155).interfaceId ||
            interfaceId == type(IERC1155MetadataURI).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function uri(uint256 id) public view override returns (string memory) {
        return tokenURIs[id];
    }

    /**
     * @dev Mint a new ERC1155 Token

     * Params:
     * recipient: recipient of the new tokens
     * amount: amount to mint
     * data: data
     */
    function mintToken(
        address recipient,
        uint256 amount,
        bytes memory data,
        string memory URI
    ) external onlyAdmin {
        uint256 tokenId = generateTokenId();
        tokenURIs[tokenId] = URI;
        _mint(recipient, tokenId, amount, data);
        totalSupply += amount;
    }

    function mintBatch(
        address to,
        uint256[] memory amounts,
        bytes memory data,
        string[] memory URIs
    ) public {
        uint256[] memory tokenIds = new uint256[](amounts.length);
        for (uint256 j = 0; j < amounts.length; j++) {
            uint256 tokenId = generateTokenId();
            tokenIds[j] = tokenId;
            tokenURIs[tokenId] = URIs[j];
            totalSupply += amounts[j];
        }
        _mintBatch(to, tokenIds, amounts, data);
    }

    //Generate next token ID
    function generateTokenId() internal returns (uint256) {
        return nextTokenId++;
    }
}
