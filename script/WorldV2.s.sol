// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {WorldV2} from "../src/WorldV2.sol";

contract WorldScript is Script {
    WorldV2 public world;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        world = new WorldV2();
        console.log("Address of WorldV2 : ", address(world));

        vm.stopBroadcast();
    }
}
