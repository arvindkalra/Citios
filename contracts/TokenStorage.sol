pragma solidity >=0.4.21 <0.6.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import './Ownable.sol';

/**
* @title TokenStorage
*/
contract TokenStorage  is Ownable{
    using SafeMath for uint256;

//    mapping (address => bool) internal _allowedAccess;

    // Access Modifier for Storage contract
    address internal _registryContract;

    constructor() public {
        _owner = msg.sender;
    }

    function setProxyContractAndVersionOneDeligatee(address registryContract) onlyOwner public{
        require(registryContract != address(0), "InvalidAddress: invalid address passed for proxy contract");
        _registryContract = registryContract;
    }

    function getRegistryContract() view public returns(address){
        return _registryContract;
    }

//    function addDeligateContract(address upgradedDeligatee) public{
//        require(msg.sender == _registryContract, "AccessDenied: only registry contract allowed access");
//        _allowedAccess[upgradedDeligatee] = true;
//    }

    modifier onlyAllowedAccess() {
        require(msg.sender == _registryContract, "AccessDenied: This address is not allowed to access the storage");
        _;
    }

    // Allowances with its Getter and Setter
    mapping (address => mapping (address => uint256)) internal _allowances;

    function setAllowance(address _tokenHolder, address _spender, uint256 _value) public onlyAllowedAccess {
        _allowances[_tokenHolder][_spender] = _value;
    }

    function getAllowance(address _tokenHolder, address _spender) public view onlyAllowedAccess returns(uint256){
        return _allowances[_tokenHolder][_spender];
    }


    // Balances with its Getter and Setter
    mapping (address => uint256) internal _balances;
    function addBalance(address _addr, uint256 _value) public onlyAllowedAccess {
        _balances[_addr] = _balances[_addr].add(_value);
    }

    function subBalance(address _addr, uint256 _value) public onlyAllowedAccess {
        _balances[_addr] = _balances[_addr].sub(_value);
    }

    function setBalance(address _addr, uint256 _value) public onlyAllowedAccess {
        _balances[_addr] = _value;
    }

    function getBalance(address _addr) public view onlyAllowedAccess returns(uint256){
        return _balances[_addr];
    }

    // Total Supply with Getter and Setter
    uint256 internal _totalSupply = 0;

    function addTotalSupply(uint256 _value) public onlyAllowedAccess {
        _totalSupply = _totalSupply.add(_value);
    }

    function subTotalSupply(uint256 _value) public onlyAllowedAccess {
        _totalSupply = _totalSupply.sub(_value);
    }

    function setTotalSupply(uint256 _value) public onlyAllowedAccess {
        _totalSupply = _value;
    }

    function getTotalSupply() public view onlyAllowedAccess returns(uint256) {
        return(_totalSupply);
    }


    // Locker with Getter and Setter
    mapping(address => bool) internal locked;

    function checkLocked(address user) public view onlyAllowedAccess returns(bool){
        return locked[user];
    }

    function setLocked(address user) public onlyAllowedAccess {
        locked[user] = true;
    }

    function unSetLocked(address user) public onlyAllowedAccess {
        locked[user] = false;
    }

    function caller() public view  onlyAllowedAccess returns(address){
        return msg.sender;
    }
}