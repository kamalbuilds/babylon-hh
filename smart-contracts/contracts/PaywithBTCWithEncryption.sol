 // SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract PaywithBTCWithEncryption {
    using SafeERC20 for IERC20;

    uint256 public constant SCHEME_ID = 1;

    event Announcement(
        uint256 indexed schemeId,
        address indexed stealthAddress,
        address indexed caller,
        bytes ephemeralPubKey,
        bytes encryptedMessage, // Changed metadata to encryptedMessage
        uint256 timestamp
    );

    error PaywithBTC__InvalidAmount();
    error PaywithBTC__AddressZero();
    error PaywithBTC__InvalidMessageLength();

    function sendEthWithMessage(
        address receiver,
        bytes calldata ephemeralPubKey,
        bytes calldata encryptedMessage
    ) external payable {
        if (msg.value == 0) revert PaywithBTC__InvalidAmount();
        if (receiver == address(0)) revert PaywithBTC__AddressZero();
        if (encryptedMessage.length == 0) revert PaywithBTC__InvalidMessageLength();

        (bool success, ) = payable(receiver).call{value: msg.value}("");
        require(success, "ETH transfer failed");

        emit Announcement(
            SCHEME_ID,
            receiver,
            msg.sender,
            ephemeralPubKey,
            encryptedMessage,
            block.timestamp
        );
    }

    function sendERC20WithMessage(
        address receiver,
        address tokenAddress,
        uint256 amount,
        bytes calldata ephemeralPubKey,
        bytes calldata encryptedMessage
    ) external {
        if (amount == 0) revert PaywithBTC__InvalidAmount();
        if (receiver == address(0) || tokenAddress == address(0)) revert PaywithBTC__AddressZero();
        if (encryptedMessage.length == 0) revert PaywithBTC__InvalidMessageLength();

        IERC20(tokenAddress).safeTransferFrom(msg.sender, receiver, amount);
        
        emit Announcement(
            SCHEME_ID,
            receiver,
            msg.sender,
            ephemeralPubKey,
            encryptedMessage,
            block.timestamp
        );
    }
}