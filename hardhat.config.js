require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" });

const ALCHEMY_API = process.env.ALCHEMY_API;
const GOERLI_PRIVATE_KEY = process.env.GOERLI_PRIVATE_KEY;


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks:{
    // rinkeby: {
    //   url: ALCHEMY_API_KEY_URL,
    //   accounts: [RINKEBY_PRIVATE_KEY],
    // },
    goerli: {
      url: ALCHEMY_API,
      accounts: [GOERLI_PRIVATE_KEY],
    }
  }
};
