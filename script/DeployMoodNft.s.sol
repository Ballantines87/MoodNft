// SPDX-License-Identifier:MIT
pragma solidity ^0.8.20;

import {MoodNft} from "../src/MoodNft.sol";
import {Script, console} from "forge-std/Script.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        // example:
        // <svg width="..."
        // data:image/svg+xml;base64, PHN....
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );

        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }

    function run() public returns (MoodNft) {
        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");

        vm.startBroadcast();
        MoodNft moodNFT = new MoodNft(
            svgToImageURI(sadSvg),
            svgToImageURI(happySvg)
        );

        vm.stopBroadcast();
        console.log(moodNFT.tokenURI(0));
        return moodNFT;
    }
}
