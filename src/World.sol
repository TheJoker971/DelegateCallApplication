// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721} from '@openzeppelin/contracts/token/ERC721/ERC721.sol';

contract World is ERC721 {

    address private _owner;
    
    constructor(string memory _name, string memory _symbol) ERC721(_name,_symbol){
        _owner = msg.sender;
    }

    
}
