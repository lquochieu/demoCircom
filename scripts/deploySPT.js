const hre = require("hardhat");
const { poseidonContract } = require('circomlibjs');


async function main() {
    const [deployer,] = await hre.ethers.getSigners();
    const P2 = new ethers.ContractFactory(
        poseidonContract.generateABI(2),
        poseidonContract.createCode(2),
        deployer
    );
    const poseidon2 = await P2.deploy();
    await poseidon2.deployed();
    console.log("Poseidon2 deploy successed", poseidon2.address);


    console.log("======================Poseidon=======================")
    console.log("Poseidon2 Address: ", poseidon2.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});