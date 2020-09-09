pragma solidity ^0.6.0;

import "./Token.sol";
import "./Promocode.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";


contract Distribution is Token,Promocode,Ownable{
    mapping (address=>token) public list ;
    
    event Record(address indexed _to,bool minted);

    modifier valid_no_of_tokens(uint no_of_tokens){
    require(no_of_tokens<=100);
    _;
    }
    function mint_tokens(uint no_of_tokens) public onlyOwner  valid_no_of_tokens(no_of_tokens){
        list[owner()].minted=true;
        list[owner()].no_of_tokens+=no_of_tokens;
        emit Record(owner(),true);
    }
    function ApplyPromoCode(code _code) internal first_time(_code) returns(uint){
        _default=code.ORDANIARY;
        if(_code==code.FIRST){
            return 5;
        }
        else{
            return 0;
        }
        
    }
    
    function BuyToken(address _buyer,uint _tokens,code PROMO)public  max_tokens(_tokens){
        require(msg.sender!=owner());
        require(list[owner()].minted==true);
        require(_tokens<list[owner()].no_of_tokens);
         uint increament=ApplyPromoCode(PROMO);
        list[_buyer].minted=true;
        list[_buyer].no_of_tokens+=_tokens+increament;
        list[owner()].no_of_tokens-=_tokens;
       emit Record(_buyer,true);
    }
    function tokensLeft() public view onlyOwner  returns(uint){
      return list[owner()].no_of_tokens;   
    }
}