// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {World} from "../src/World.sol";

contract WorldTest is Test {
    World public world;

    function setUp() public {
        world = new World("Joker Paradise","PRDZ");
    }

    function TestMint() public {
        world.mint("Gotham",0,0);
        assertEq(world.getProperty(0).name,"Gotham");
    }
}
