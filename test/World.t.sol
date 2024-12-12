// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {World} from "../src/World.sol";

contract WorldTest is Test {
    World public world;

    function setUp() public {
        world = new World("Test","TEST");
    }

    function testMint() public {
        world.mint(1,1);
        vm.expectRevert(abi.encodeWithSelector(World.POSITION_ALREADY_USED.selector, 1, 1));
        world.mint(1,1);
        assertEq(world.getPositionOf(0).x,1);
        assertEq(world.getPositionOf(0).y,1);
        assertEq(world.getNumberOfProperties(),1);
    }
    
}
