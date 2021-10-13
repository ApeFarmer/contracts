require("dotenv").config();
require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-waffle");


// You have to export an object to set up your config
// This object can have the following optional entries:
// defaultNetwork, networks, solc, and paths.
// Go to https://buidler.dev/config/ to learn more
module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.7.3",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.6.0",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.8.0",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.6.12",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ],
  },
  //defaultNetwork: "goerli",
  networks: {
    local: {
      url: "http://localhost:8545",
    },
    bscTestnet: {
      url: process.env.BINANCE_TESTNET_URL,
      accounts: [process.env.BINANCE_TESTNET_PRIVATE_KEY],
    },
    bsc: {
      url: process.env.BSC_URL,
      accounts: [process.env.BSC_PRIVATE_KEY],
    },
  },
  solc: {
    version: "0.6.12",
  },
  paths: {
    //tests: "./test/doge",
  },
  etherscan: {
    apiKey: process.env.BSCSCAN_KEY,
  },
};
