// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721} from '@openzeppelin/contracts/token/ERC721/ERC721.sol';

contract World is ERC721 {
    
    error POSITION_ALREADY_USED(uint256,uint256);

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


    constructor(string memory _name, string memory _symbol) ERC721(_name,_symbol){
        _owner = tx.origin;
    }

    modifier _positionNotEmpty(uint256 _x,uint256 _y) {
        if (!_registerPositions[_x][_y]){
            revert POSITION_ALREADY_USED(_x,_y);
        }
        _;
    }

    function mint(string memory _name,uint256 _x,uint256 _y) _positionNotEmpty(_x,_y) public payable {
        _mint(tx.origin,numberOfProperty);
        properties[numberOfProperty] = Property(_name,_x,_y);
        numberOfProperty++;
    }

    function getProperty(uint256 _propertyID) public view returns(Property memory){
        return properties[_propertyID];
    }


    
}
