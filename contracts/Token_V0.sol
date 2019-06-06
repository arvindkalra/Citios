pragma solidity >=0.4.21 <0.6.0;

import "./TokenStorage.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/AddressUtils.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import './Ownable.sol';

/**
* @title Token_V0
* @notice A basic ERC20 token with modular data storage
*/
contract Token_V0 is ERC20,Ownable {
    using SafeMath for uint256;

    /** Events */
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed burner, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    TokenStorage dataStore;

    constructor(address storeAddress) public {
        dataStore = TokenStorage(storeAddress);
    }

    /** Modifiers **/

    /** Functions **/

    function setInitials(uint256 totalSupply) public{
        dataStore.setTotalSupply(totalSupply);
    }

    function totalSupply() public view returns(uint256) {
        return(dataStore.getTotalSupply());
    }

    function balanceOf(address account) public view returns (uint256) {
        return dataStore.getBalance(account);
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return dataStore.getAllowance(owner, spender);
    }

    function approve(address spender, uint256 value) public returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, dataStore.getAllowance(sender, msg.sender).sub(amount));
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(!dataStore.checkLocked(sender), "TransactionsLocked: Transactions are locked by the owner");

        dataStore.subBalance(sender, amount);
        dataStore.addBalance(recipient, amount);
        emit Transfer(sender, recipient, amount);
    }

    function _approve(address owner, address spender, uint256 value) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        dataStore.setAllowance(owner, spender, value);
        emit Approval(owner, spender, value);
    }

    function mintToken(address recipient, uint256 value) public onlyOwner{
        dataStore.addTotalSupply(value);
        dataStore.addBalance(recipient, value);
        emit Mint(recipient, value);
    }

    function burnToken(uint256 value) public{
        address sender = msg.sender;
        dataStore.subBalance(sender, value);
        dataStore.subTotalSupply(value);
        emit Burn(msg.sender, value);
    }

    function lockTransactions(address user) public onlyOwner{
        dataStore.setLocked(user);
    }

    function unlockTransactions(address user) public onlyOwner{
        dataStore.unSetLocked(user);
    }

    function caller() public view returns(address){
        return dataStore.caller();
    }

}