// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Proxy} from "../src/Proxy.sol";
import {World} from "../src/World.sol";
import {WorldV2} from "../src/WorldV2.sol";

contract ProxyScript is Script {
    Proxy public proxy;

    function setUp() public {
        proxy = Proxy(0x9cEB0ECff78Cecbc3cB1dBbc66Ed3f0A7AEbB4Fa);
    }

    function run() public {
        vm.startBroadcast();
        // proxy.setDelegation(address(0x9289A0C190797f75a1802aC72dd01c3cCdb786eF));
        // World(address(proxy)).mint(0,1);
        // World(address(proxy)).mint(1,1);
        // World(address(proxy)).mint(0,2);
        // World(address(proxy)).mint(1,2);
        proxy.balanceOf(0x293032BA5dcC00f817dF26d59529AeeD5dfFf3aE);
        proxy.numberOfProperties();
        // proxy.setDelegation(address(0x37d2b2ca45B85F45Ea07C990D2993CFcE674E27e));
        // WorldV2(address(proxy)).transfer(0x293032BA5dcC00f817dF26d59529AeeD5dfFf3aE,0);
        // WorldV2(address(proxy)).transfer(0x293032BA5dcC00f817dF26d59529AeeD5dfFf3aE,2);
        vm.stopBroadcast();
    }
}
