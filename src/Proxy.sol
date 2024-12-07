// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Proxy {

    error WORLD_ALREADY_REGISTER(string,string);
    error DELEGATION_FAILED();
    error ID_NOT_VALID(uint256);

    address private _owner;//slot 0

    uint256 numberOfProperty;// slot 1

    struct Property { // slot dynamic
        string name; 
        uint256 x;
        uint256 y;
    }
    mapping(uint256 => Property) properties; //slot 2
    mapping(address => bool) private _balanceVisibility;// slot 3
    mapping(address => uint256) private _balances;// slot 4
    mapping(uint256 => address) private _owners;
    mapping(uint256 => mapping(uint256 => bool)) private _registerPositions; // slot 5

    uint256 numberOfWorld; //slot 6
    mapping(uint256 => address) private _worlds; // slot 7
    address selectedWorld;

    constructor(){

    }

    modifier _validWorldID(uint256 _worldID){
        if(_worldID >= numberOfWorld){
            revert ID_NOT_VALID(_worldID);
        }
        _;
    }

    function newWorld(address _addr) public {
        _worlds[numberOfWorld] = _addr;
        selectedWorld = _addr;
        numberOfWorld++;
    }

    function setWorld(uint256 _worldID) _validWorldID(_worldID) public {
        selectedWorld = _worlds[_worldID];
    }

    receive() external payable{}

    fallback() external payable{
        (bool success,) = selectedWorld.delegatecall(msg.data);
        if(!success){
            revert DELEGATION_FAILED();
        }
    }

}