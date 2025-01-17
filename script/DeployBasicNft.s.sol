// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {BasicNft} from "../src/BasicNft.sol";
import {Script} from "forge-std/Script.sol";

contract DeployBasicNft is Script {
    function run() public returns (BasicNft) {
        vm.startBroadcast();
        BasicNft basicNFT = new BasicNft();
        vm.stopBroadcast();
        return basicNFT;
    }
}
