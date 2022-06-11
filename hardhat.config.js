
require("@nomiclabs/hardhat-waffle");
require("hardhat-contract-sizer");
require("@nomiclabs/hardhat-truffle5");
require("hardhat-gas-reporter");
require("hardhat-spdx-license-identifier");

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

module.exports = {
  solidity: {
    version: "0.8.7",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  contractSizer: {
    alphasort: false,
    disambiguatePaths: false,
    runOnCompile: true,
    strict: false
  },
    gasReporter: {
    enabled: true,
    currency: 'USD',
    coinmarketcap: "",
    gasPrice: 70,
  },
  spdxLicenseIdentifier: {
    overwrite: false,
    runOnCompile: true,
  }
};


