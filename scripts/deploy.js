const main = async () => {
  const domainContractFactory = await hre.ethers.getContractFactory("Domains");
  const domainContract = await domainContractFactory.deploy("dood");
  await domainContract.deployed();

  console.log("Contract deployed to:", domainContract.address);

  let txn = await domainContract.register("happy", {
    value: hre.ethers.utils.parseEther("0.1"),
  });
  await txn.wait();
  console.log("Minted domain happy.dood");

  txn = await domainContract.setRecord("happy", "Yippeeeeeee");
  await txn.wait();
  console.log("Set record for happy.dood");

//   txn = await domainContract.setDoodleID("dood", "6869");
//   await txn.wait();
//   console.log("Set record for happy.dood");

  const address = await domainContract.getAddress("happy");
  console.log("Owner of domain happy:", address);

  const balance = await hre.ethers.provider.getBalance(domainContract.address);
  console.log("Contract balance:", hre.ethers.utils.formatEther(balance));
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
