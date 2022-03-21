const HDWalletProvider = require('@truffle/hdwallet-provider');
//const infuraKey = "cb00007b91152d112f40af2b6a624d5f97f75b950dd0c30ef81cf96f1486a102";
const {
  mnemonic,
  //etherscanApiKey,
  //snowtraceApiKey,
} = require('./secrets.json');
module.exports = {
  // Uncommenting the defaults below
  // provides for an easier quick-start with Ganache.
  // You can also follow this format for other networks;
  // see <http://truffleframework.com/docs/advanced/configuration>
  // for more details on how to specify configuration options!
  //
  networks: {
    ropsten: {
      //provider: () => new HDWalletProvider(mnemonic, `wss://ropsten.infura.io/ws/v3/bb2a6ee4fdf9450592973d530f96cf12`),
      provider: () =>
        new HDWalletProvider(
          mnemonic,
          `wss://speedy-nodes-nyc.moralis.io/cc096b4132ca028a5379df4a/eth/ropsten/ws`
        ),
      network_id: 3, //
      //numberOfAddresses: 1,
      //gas: 9500000, // rinkeby 有下块限制比主网
      //gasPrice: 10000000000,
      networkCheckTimeout: 1000000, // 注意：这个选项什么都不做
      confirmations: 2, // 在部署之间等待的 confs 数量。(默认: 0)
      timeoutBlocks: 200, // 部署超时前的块数 (minimum/default: 50)
      skipDryRun: true, // 在迁移之前跳过试运行？（默认：公共网络为假）
    },
    rinkeby: {
      //provider: () => new HDWalletProvider(mnemonic, `wss://ropsten.infura.io/ws/v3/bb2a6ee4fdf9450592973d530f96cf12`),
      provider: () =>
        new HDWalletProvider(
          mnemonic,
          `wss://speedy-nodes-nyc.moralis.io/cc096b4132ca028a5379df4a/eth/rinkeby/ws`
        ),
      network_id: 4, //
      //numberOfAddresses: 1,
      //gas: 9500000, // rinkeby 有下块限制比主网
      //gasPrice: 10000000000,
      networkCheckTimeout: 1000000, // 注意：这个选项什么都不做
      confirmations: 2, // 在部署之间等待的 confs 数量。(默认: 0)
      timeoutBlocks: 200, // 部署超时前的块数 (minimum/default: 50)
      skipDryRun: true, // 在迁移之前跳过试运行？（默认：公共网络为假）
    },
    avaxTest: {
      provider: () =>
        new HDWalletProvider(
          mnemonic,
          `wss://speedy-nodes-nyc.moralis.io/cc096b4132ca028a5379df4a/avalanche/testnet/ws`
        ),
      network_id: 43113, //
      //numberOfAddresses: 1,
      //gas: 9500000, // rinkeby 有下块限制比主网
      //gasPrice: 10000000000,
      networkCheckTimeout: 1000000, // 注意：这个选项什么都不做
      confirmations: 2, // 在部署之间等待的 confs 数量。(默认: 0)
      timeoutBlocks: 200, // 部署超时前的块数 (minimum/default: 50)
      skipDryRun: true, // 在迁移之前跳过试运行？（默认：公共网络为假）
    },
    bscTest: {
      provider: () =>
        new HDWalletProvider(
          mnemonic,
          `wss://speedy-nodes-nyc.moralis.io/cc096b4132ca028a5379df4a/bsc/testnet/ws`
        ),
      network_id: 97,
      //numberOfAddresses: 1,
      // gas: 9500000, // rinkeby 有下块限制比主网
      // gasPrice: 10000000000,
      networkCheckTimeout: 1000000, // 注意：这个选项什么都不做
      confirmations: 2, // 在部署之间等待的 confs 数量。(默认: 0)
      timeoutBlocks: 200, // 部署超时前的块数 (minimum/default: 50)
      skipDryRun: true, // 在迁移之前跳过试运行？（默认：公共网络为假）
    },
    polyTest: {
      provider: () =>
        new HDWalletProvider(
          mnemonic,
          `wss://speedy-nodes-nyc.moralis.io/cc096b4132ca028a5379df4a/polygon/mumbai/ws`
        ),
      network_id: 80001,
      //numberOfAddresses: 1,
      // gas: 9500000, // rinkeby 有下块限制比主网
      // gasPrice: 10000000000,
      networkCheckTimeout: 1000000, // 注意：这个选项什么都不做
      confirmations: 2, // 在部署之间等待的 confs 数量。(默认: 0)
      timeoutBlocks: 200, // 部署超时前的块数 (minimum/default: 50)
      skipDryRun: true, // 在迁移之前跳过试运行？（默认：公共网络为假）
    },
    //  development: {
    //    host: "127.0.0.1",
    //    port: 7545,
    //    network_id: "*"
    //  },
    //  test: {
    //    host: "127.0.0.1",
    //    port: 7545,
    //    network_id: "*"
    //  }
  },
  //
  compilers: {
    solc: {
      settings: {
        optimizer: {
          enabled: true,
          runs: 200,
        },
      },
      version: '0.8.7',
    },
  },
  //plugins: ['truffle-plugin-verify'],
  //api_keys: {
  //etherscan: etherscanApiKey,
  //snowtrace: snowtraceApiKey,
  //},
};
