pragma solidity ^0.6.0;

contract Promocode{
    enum code{
        FIRST,
        ORDANIARY
    }
    code  _default;
    constructor()public{
        _default=code.FIRST;
    }
    modifier first_time(code _code){
        require(_default==_code,"Can't be applied");
        _;
    }
}
