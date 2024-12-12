// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721} from '@openzeppelin/contracts/token/ERC721/ERC721.sol';

contract World is ERC721 {

    /*          ERROR           */
    error POSITION_ALREADY_USED(uint256,uint256);

    /*              END             */

    /*              SLOT               */
    // string private _name; 0

    // string private _symbol; 1

    address private _owner; // 2
    uint256 numberOfProperties;//3

    /*              END             */

    /*          DYNAMIC           */

    mapping(uint256 => mapping(uint256 => bool)) private _registerPositions;
    mapping(uint256 propertyID => Position) private _registerProperties;
    // mapping(uint256 tokenId => address) private _owners;

    // mapping(address owner => uint256) private _balances;

    struct Position {
        uint256 x;
        uint256 y;
    }
    /*              END              */
    
    constructor(string memory _name, string memory _symbol) ERC721(_name,_symbol){
        _owner = msg.sender;
    }

    modifier _positionNotUsed(uint256 _x, uint256 _y) {
        if(_registerPositions[_x][_y]){
            revert POSITION_ALREADY_USED(_x,_y);
        }
        _;
    }

    function mint(uint256 _x, uint256 _y) _positionNotUsed(_x,_y) public {
        _registerPositions[_x][_y] = true;
        _registerProperties[numberOfProperties] = Position(_x,_y);
        numberOfProperties++;
    }

    function getNumberOfProperties() public view returns(uint256) {
        return numberOfProperties;
    }

    function getPositionOf(uint256 _propertyID) public view returns(Position memory){
        return _registerProperties[_propertyID];
    }

    
}
