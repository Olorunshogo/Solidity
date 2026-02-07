import { baseConfig } from '../hardhat.base.js';

export default {
  ...baseConfig,
  paths: {
    sources: './contracts',
    tests: './test',
    artifacts: './artifacts',
    cache: './cache',
  },
};
