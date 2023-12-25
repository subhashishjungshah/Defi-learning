# Flash Loans

This project demonstrates a flashloan concept in binance smart chain. Flash loans are a unique feature in decentralized finance (DeFi) that allow users to borrow assets from a liquidity pool within a single transaction, without the need for collateral. These loans are typically borrowed and repaid within the same transaction block on the blockchain.

# Project Structure

## Interfaces used in this project

- IUniswapV2Factory: Responsible for deploying new instances of uniswap trading pairs. Deals with liquidity pools.
- IERC20: Responsible for transferring tokens, quering the balance of an address, and approving third parties to spend tokens on our behalf.
- IUniswapV2Pair: Responsible for getting the address of tokens in the liquidity pool.
- IUniswapV2Router01&02: Responsible for executing swaps and providing liquidity in the uniswap protocol.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```
