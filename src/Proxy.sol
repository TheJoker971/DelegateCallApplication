// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Proxy {

    /*          ERROR           */
    error DELEGATION_FAILED();
    error PERMISSION_DENIED();

    /*              END             */

     /*              SLOT               */
    string private _name; //0

    string private _symbol; //1

    address private _owner; // 2
    uint256 numberOfProperties;//3
    address private _delegation;//4 

    /*              END             */

    /*          DYNAMIC           */

    mapping(uint256 => mapping(uint256 => bool)) private _registerPositions;
    mapping(uint256 propertyID => Position) private _registerProperties;
    mapping(uint256 tokenId => address) private _owners;

    mapping(address owner => uint256) private _balances;

    struct Position {
        uint256 x;
        uint256 y;
    }
    /*              END              */

    constructor(){
        _owner = msg.sender;
    }

    modifier _onlyOwner(address _sender) {
        if(_owner != _sender){
            revert PERMISSION_DENIED();
        }
        _;
    }

    fallback() external {
        (bool success,) = _delegation.delegatecall(msg.data);
        if(!success){
            revert DELEGATION_FAILED();
        }
    }

    function setDelegation(address _impl) _onlyOwner(msg.sender) public {
        _delegation = _impl;
    }

}