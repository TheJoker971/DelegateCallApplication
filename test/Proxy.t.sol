// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Proxy} from "../src/Proxy.sol";
import {World} from "../src/World.sol";
import {WorldV2} from "../src/WorldV2.sol";

contract ProxyTest is Test {

    Proxy public proxy;
    World public world;
    WorldV2 public world2;
    address public aProxy;

    function setUp() public {
        world = new World("Testing", "TEST");
        proxy = new Proxy();
        world2 = new WorldV2();
        aProxy = address(proxy);
        proxy.setDelegation(address(world));
        aProxy.call(abi.encodeWithSignature("mint(uint256,uint256)", 1, 12));
    }
    //0x293032BA5dcC00f817dF26d59529AeeD5dfFf3aE
    function testSetDelegation() public {
        proxy.setDelegation(address(world));
        assertEq(proxy.getDelegation(), address(world));
    }

    function testMintDelegate() public {
        vm.expectRevert(abi.encodeWithSelector(World.POSITION_ALREADY_USED.selector,1,12));
        aProxy.call(abi.encodeWithSignature("mint(uint256,uint256)", 1, 12));
    }

    function testMintDelegate2() public {
        proxy.setDelegation(address(world2));
        vm.expectRevert(abi.encodeWithSelector(WorldV2.POSITION_ALREADY_USED.selector,1,12));
        aProxy.call(abi.encodeWithSignature("mint(uint256,uint256)", 1, 12));
        aProxy.call(abi.encodeWithSignature("mint(uint256,uint256)", 2, 12));
        assertEq(proxy.getNumberOfProperties(),2,"Number of properties not matched");
    }

    function testTransferDelegate() public {
        proxy.setDelegation(address(world2));
        aProxy.call(abi.encodeWithSignature("mint(uint256,uint256)", 2, 12));
        aProxy.call(abi.encodeWithSignature("transfer(address,uint256)",address(0x293032BA5dcC00f817dF26d59529AeeD5dfFf3aE) , 1));
        assertEq(proxy.ownerOf(1),0x293032BA5dcC00f817dF26d59529AeeD5dfFf3aE);
    }
}
