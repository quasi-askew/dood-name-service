import useDoodStore from "../doodStore";
import { Button } from "@chakra-ui/react";

declare var window: any;

export default function ConnectWallet({}) {
  const setCurrentAccount = useDoodStore((state) => state.setCurrentAccount);

  const connectWallet = async () => {
    try {
      const { ethereum } = window;

      if (!ethereum) {
        alert("Get MetaMask -> https://metamask.io/");
        return;
      }

      // Fancy method to request access to account.
      const accounts = await ethereum.request({
        method: "eth_requestAccounts",
      });

      // Boom! This should print out public address once we authorize Metamask.
      console.log("Connected", accounts[0]);
      setCurrentAccount(accounts[0]);
    } catch (error) {
      console.log(error);
    }
  };
  return (
    <div>
      <Button onClick={connectWallet} colorScheme="blue">
        Connect Wallet
      </Button>
    </div>
  );
}
