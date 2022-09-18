const {ethers} = require("hardhat");
const hre = require("hardhat");
require("dotenv").config({ path: ".env"});
const { WHITELIST_CONTRACT_ADDRESS, METADATA_URL } = require("../constants");

async function main() {
  const whiteListContract = WHITELIST_CONTRACT_ADDRESS
  const metadataURL = METADATA_URL;

  const cryptoDevsContract = await ethers.getContractFactory("Godright")
  const deployedCryptoDevsContract = await deployedCryptoDevsContract.deploy(
    metadataURL,
    whiteListContract
  );

  console.log(
    "Godright contract:",
    deployedCryptoDevsContract.address
  )
}

main()
  .then(()=> process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});
