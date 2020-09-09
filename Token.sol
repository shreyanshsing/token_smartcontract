pragma solidity ^0.6.0;

contract Token{
    
    struct token{
        bool minted;
        uint no_of_tokens;
    }
   
    modifier max_tokens(uint _tokens){
        require(_tokens<=10,"You can't purchase more than 10 token at once.");
        _;
    }
}
 