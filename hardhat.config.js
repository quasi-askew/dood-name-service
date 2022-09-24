require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.10",
  networks: {
    mumbai: {
      url: process.env.MUMBAI_URL,
      accounts: [process.env.MUMBAI_TEST_ACCOUNT],
    },
  },
};
