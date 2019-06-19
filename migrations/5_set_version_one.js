var TokenProxy = artifacts.require("./TokenProxy.sol");
var TokenStorage = artifacts.require("./TokenStorage.sol");

module.exports = function(deployer, network, accounts) {
    let owner = accounts[0];
    TokenProxy.deployed().then(function () {
        TokenStorage.at(TokenStorage.address)
            .setProxyContractAndVersionOneDeligatee(TokenProxy.address, {from: owner})
        console.log("Version 1 set");
    });
};
