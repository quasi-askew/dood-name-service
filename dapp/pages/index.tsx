import { useEffect } from "react";
import Head from "next/head";
import ConnectWallet from "../components/ConnectWallet";
import Footer from "../components/Footer";
import Layout from "../components/Layout";
import useDoodStore from "../doodStore";
import { Heading } from "@chakra-ui/react";

declare var window: any;

export default function Home() {
  const currentAccount = useDoodStore((state) => state.currentAccount);
  const setCurrentAccount = useDoodStore((state) => state.setCurrentAccount);

  const checkIfWalletIsConnected = async () => {
    const { ethereum } = window;

    if (!ethereum) {
      return;
    }

    const accounts = await ethereum.request({ method: "eth_accounts" });

    // Users can have multiple authorized accounts, we grab the first one if its there!
    if (accounts.length !== 0) {
      const account = accounts[0];
      console.log("Found an authorized account:", account);
      setCurrentAccount(account);
    } else {
      console.log("No authorized account found");
    }
  };

  useEffect(() => {
    checkIfWalletIsConnected();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <>
      <Heading as="h1">Dood Name Service 🌈</Heading>
      {!currentAccount && <ConnectWallet />}
    </>
  );
}

Home.getLayout = function getLayout(page) {
  return <Layout>{page}</Layout>;
};
