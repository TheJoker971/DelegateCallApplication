// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract World{
    
    error NOT_VALID_ADDRESS();
    error POSITION_ALREADY_USED(uint256,uint256);
    error AUTHORIZATION_DENIED();

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

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    modifier _positionNotUsed(uint256 _x, uint256 _y) {
        if(_registerPosition[_x][_y]){
            revert POSITION_ALREADY_USED(_x,_y);
        }
        _;
    }

    modifier _isOwner(address _sender, uint256 _propertyID){
        if(_owners[_propertyID] != _sender) {
            revert AUTHORIZATION_DENIED();
        }
        _;
    }


    function _transfer(address _to, uint256 _propertyID) internal {
        _owners[_propertyID] = _to;
        _balances[_to]++;
    }

    function _transferFrom(address _from, address _to, uint256 _propertyID) internal {
        _balances[_from]--;
        _owners[_propertyID] = _to;
        _balances[_to]++;
    }

    function _addingPosition(uint256 _propertyID, uint256 _x, uint256 _y) internal {
        _positionOfProperty[_propertyID] = Position(_x,_y);
        _registerPosition[_x][_y] = true;
    }

    function _update(address _to,uint256 _propertyID) internal{
        if(_to == address(0)){
            revert NOT_VALID_ADDRESS();
        }
        address owner = _owners[_propertyID];
        if(owner != address(0)){
            _transferFrom(owner,_to,_propertyID);
        }else{
            _transfer(_to,_propertyID);
        }
    }

    function mint(uint256 _x, uint256 _y) public {
        _update(tx.origin,numberOfProperty);
        _addingPosition(numberOfProperty,_x,_y);
        numberOfProperty++;
    }

    
}
