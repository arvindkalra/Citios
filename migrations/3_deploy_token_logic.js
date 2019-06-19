var Token_V0 = artifacts.require("./Token_V0.sol");
var TokenStorage = artifacts.require("./TokenStorage.sol");
var Token_V1 = artifacts.require("./Token_V1.sol");

module.exports = function(deployer, network, accounts) {
  let owner = accounts[0];
  console.log('owner of tokenContracts' + owner)
  deployer.deploy(Token_V0, TokenStorage.address, {from:owner});
  // deployer.deploy(Token_V1, TokenStorage.address, {from:owner});
};
