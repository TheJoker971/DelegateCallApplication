// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Proxy} from "../src/Proxy.sol";
import {World} from "../src/World.sol";

contract ProxyTest is Test {
    Proxy public proxy;
    World public world;

    function setUp() public {
        world = new World("Testing", "TEST");
        proxy = new Proxy();
    }

    function testSetDelegation() public {
        proxy.setDelegation(address(world));
        assertEq(proxy.getDelegation(), address(world));
    }

    function testMintDelegate() public {
        proxy.setDelegation(address(world));
        address(proxy).call(abi.encodeWithSignature("mint(uint256,uint256)", 1, 12));
        assertEq(proxy.getNumberOfProperties(), 1);
        assertEq(proxy.getPositionOf(0).x, 1);
        assertEq(proxy.getPositionOf(0).y, 12);
    }
}
