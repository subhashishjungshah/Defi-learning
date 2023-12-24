const ethers = require("ethers");
const {
  factoryAddress,
  routerAddress,
  fromAddress,
  toAddress,
} = require("./Address");

const { erc20ABI, factoryABI, pairABI, routerABI } = require("ABIInfo");

const provider = new ethers.providers.JsonRpcProvider(
  "https://bsc-dataseed1.binance.org/"
);

const factoryInstance = new ethers.Contract(
  factoryAddress,
  factoryABI,
  provider
);

const routerInstance = new ethers.Contract(routerAddress, routerABI, provider);

(async () => {
  const token1 = new ethers.Contract(fromAddress, erc20ABI, provider);
  const token2 = new ethers.Contract(toAddress, erc20ABI, provider);

  const decimal1 = await token1.decimals();
  const decimal2 = await token2.decimals();

  //   Converting the token1 amount to wei
  const amountIn = ethers.utils.parseUnits("100", decimal1).toString();

  //   Using router method to convert the swap tokens
  const amountOut = await routerInstance.getAmountsOut(amountIn, [
    fromAddress,
    toAddress,
  ]);

  //   Converting again into human readable format
  const readableAmountOut = ethers.utils.formatUnits(
    amountOut[1].toString(),
    decimal2
  );
  console.log(readableAmountOut);
})();
