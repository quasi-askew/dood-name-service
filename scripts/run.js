const main = async () => {
  // The first return is the deployer, the second is a random account
  // const [owner, randomPerson] = await hre.ethers.getSigners();
  const domainContractFactory = await hre.ethers.getContractFactory("Domains");
  const domainContract = await domainContractFactory.deploy("dood");
  await domainContract.deployed();
  console.log("Contract deployed to:", domainContract.address);

  let txn = await domainContract.register("happy", {
    value: hre.ethers.utils.parseEther("0.1"),
  });
  await txn.wait();

  const domainAddress = await domainContract.getAddress("dood");
  console.log("Owner of domain dood:", domainAddress);

  const balance = await hre.ethers.provider.getBalance(domainContract.address);
  console.log("Contract balance:", hre.ethers.utils.formatEther(balance));

  // let setDoodTxn = await domainContract
  //   .connect(owner)
  //   .setDoodleID("doom", "1234");
  // await setDoodTxn.wait();

  // const doodIDSet = await domainContract.getDoodleID("doom");
  // console.log("Doodle ID is", doodIDSet);

  // // Trying to set a record that doesn't belong to me!
  // txn = await domainContract
  //   .connect(randomPerson)
  //   .setRecord("doom", "Haha my domain now!");
  // await txn.wait();

  // const recordSet = await domainContract.getRecord("doom");
  // console.log("record", recordSet);
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
