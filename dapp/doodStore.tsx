import create from "zustand";
import { devtools, persist } from "zustand/middleware";

interface DoodState {
  currentAccount: string;
  setCurrentAccount: (account: string) => void;
}

const useDoodStore = create<DoodState>()(
  devtools((set) => ({
    currentAccount: "",
    setCurrentAccount: (account) =>
      set((state) => ({ currentAccount: account })),
  }))
);
export default useDoodStore;
