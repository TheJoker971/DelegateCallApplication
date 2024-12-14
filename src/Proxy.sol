// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Proxy {

    error AUTHORIZATION_DENIED();
    error DELEGATION_FAILED();

    string public name;
    string public symbol;

    uint256 numberOfProperty;

    mapping(uint256 propertyID => address) private _owners;
    mapping(address owner => uint256) private _balances;

    mapping(uint256 propertyID => Position) private _positionOfProperty;
    mapping(uint256 x => mapping(uint256 y => bool)) private _registerPosition;

    struct Position {
        uint256 x;
        uint256 y;
    }

    address private immutable _owner;
    address private _delegation;

    constructor(){
        _owner = msg.sender;
    }

    modifier _isOwner(address _sender) {
        if(_owner != _sender){
            revert AUTHORIZATION_DENIED();
        }
        _;
    }

    function setDelegation(address _impl) _isOwner(msg.sender) public {
        _delegation = _impl;
    }

    fallback() external {
        (bool success,) = _delegation.delegatecall(msg.data);
        if(!success) {
            revert DELEGATION_FAILED();
        }
    }
}
