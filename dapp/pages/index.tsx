import { useEffect } from "react";
import Head from "next/head";
import ConnectWallet from "../components/ConnectWallet";
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
      <Head>
        <title>Dood Name Service</title>
        <meta name="description" content="Dood Name Services for Doodles" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main>
        <Heading as="h1">Dood Name Service 🌈</Heading>

        {!currentAccount && <ConnectWallet />}
      </main>

      <footer>
        <a
          href="https://twitter.com/quasi_askew"
          target="_blank"
          rel="noopener noreferrer"
        >
          @quasi_askew
        </a>
      </footer>
    </>
  );
}
