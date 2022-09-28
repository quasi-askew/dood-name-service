import Head from "next/head";
import Footer from "./Footer";

export default function Layout({ children }) {
  return (
    <>
      <Head>
        <title>Dood Name Service</title>
        <meta name="description" content="Dood Name Services for Doodles" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main>{children}</main>
      <Footer />
    </>
  );
}
