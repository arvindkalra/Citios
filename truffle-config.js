/*
 * NB: since truffle-hdwallet-provider 0.0.5 you must wrap HDWallet providers in a 
 * function when declaring them. Failure to do so will cause commands to hang. ex:
 * ```
 * mainnet: {
 *     provider: function() { 
 *       return new HDWalletProvider(mnemonic, 'https://mainnet.infura.io/<infura-key>') 
 *     },
 *     network_id: '1',
 *     gas: 4500000,
 *     gasPrice: 10000000000,
 *   },
 */
// const HDWalletProvider = require("truffle-hdwallet-provider");
// require('dotenv').config()  // Stores environment-specific variable from '.env' to process.env
const privateKey = "36B298BE4646D2044F02ADCD1AF39A9069EF798CA4EF6F439553AA05935AAE47";
const PrivateKeyProvider = require("truffle-privatekey-provider");

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!

	networks: {
		development: {
			host: 'localhost',
			port: 8545,
			network_id: '*',
		},

		kovan:{
			provider: new PrivateKeyProvider(privateKey, "https://kovan.infura.io/ZWXhYfP2uIvdg1yKuQNY"),
			network_id: 42,
			gasPrice: 1e+9
		},

		mainnet: {
			provider: new PrivateKeyProvider(privateKey, "https://mainnet.infura.io/ZWXhYfP2uIvdg1yKuQNY"),
			network_id: 1,
			gasPrice: 1e+9
		}

	},
	mocha: {
	   reporter: 'eth-gas-reporter',
	   reporterOptions: {
	     gasPrice: 21
	   }
	},
};
