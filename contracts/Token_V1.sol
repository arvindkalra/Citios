pragma solidity >=0.4.21 <0.6.0;

import "./Token_V0.sol";
//import "./dataStorage/TokenStorage.sol";
//import "../contractsold/token/Token_V0.sol";

contract Token_V1 is Token_V0{

//    TokenStorage dataStore;

    constructor(address storeAddress) Token_V0(storeAddress) public {}

    function totalSupply() public view returns(uint256) {
        return(0);
    }
//
//    function caller() public view returns(address){
//        return(address(0));
//    }
}