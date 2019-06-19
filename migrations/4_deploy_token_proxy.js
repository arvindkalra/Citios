var TokenProxy = artifacts.require("./TokenProxy.sol");
var Token_V0 = artifacts.require("./Token_V0.sol");
var TokenStorage = artifacts.require("./TokenStorage.sol");

module.exports = function(deployer, network, accounts) {
  let owner = accounts[0];
  console.log('owner of proxy contract: ' + owner);
  deployer.deploy(TokenProxy, Token_V0.address, TokenStorage.address, {from:owner});

};
