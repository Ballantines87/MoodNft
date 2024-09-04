// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNFTTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant pugGtokenURI =
        "ipfs://QmQauERhv5F4QXmUqmrw67yhMEjfWr12M1jYMVcwL3S6k9/?filename=testPUGMON.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Doggie";
        string memory actualName = basicNft.name();

        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testTickerIsCorrect() public view {
        string memory expectedTicker = "DOG";
        string memory actualTicker = basicNft.symbol();

        assert(
            keccak256(abi.encodePacked(expectedTicker)) ==
                keccak256(abi.encodePacked(actualTicker))
        );
    }

    function testCanMintAndHaveABalance() public {
        hoax(USER, 1 ether);
        basicNft.mintNft(pugGtokenURI);

        assertEq(basicNft.balanceOf(USER), 1);
        assertEq(
            keccak256(abi.encodePacked(basicNft.tokenURI(0))),
            keccak256(abi.encodePacked(pugGtokenURI))
        );
    }
}
