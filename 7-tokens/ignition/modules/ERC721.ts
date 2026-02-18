import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("ERC721Module", (m) => {
  const name = "LONER";
  const symbol = "BOM";
  const baseURI = "https://your-metadata-url.com/";

  const erc721 = m.contract("ERC721", [name, symbol, baseURI]);

  return {erc721};
});
