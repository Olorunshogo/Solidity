// hardhat.base.ts
import "@nomicfoundation/hardhat-toolbox-mocha-ethers";

export const baseConfig = {
  solidity: {
    compilers: [
      { version: '0.8.28' }
    ],
  },
  networks: {
    hardhat: {
      type: 'edr-simulated',
    },
  },
  paths: {
    sources: './contracts',
  },
  mocha: {
    grep: /^(?!.*\.t\.sol).*/,
  },
};
