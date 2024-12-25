// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {World} from "../src/World.sol";

contract WorldScript is Script {
    World public world;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        world = new World("Alabasta", "ASTA");
        console.log("Address of World : ", address(world));

        vm.stopBroadcast();
    }
}
