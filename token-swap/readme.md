# Token Swap Value Calculator with PancakeSwap

This project involves a script that utilizes PancakeSwap's factory and router contracts on the Binance Smart Chain. The script is designed to calculate and display the estimated value for swapping between two tokens. It leverages the addresses and ABIs of the PancakeSwap factory and router, allowing users to input two token addresses and fetch the approximate value of swapping one token for another on the BSC network.

## Factory Contract

The Factory Contract in decentralized exchanges serves as the cornerstone for creating new trading pairs. In the context of PancakeSwap, the Factory Contract is responsible for:

- **Pair Creation:** It facilitates the creation of new token pairs by deploying Pair Contracts.
- **Pair Address Retrieval:** It provides a method to retrieve the address of a specific token pair contract.

PancakeSwap's Factory Contract acts as a hub where new trading pairs are established, enabling users to swap between different tokens.

## Router Contract

The Router Contract plays a pivotal role in facilitating token swaps and managing liquidity on decentralized exchanges. In PancakeSwap:

- **Trade Execution:** The Router Contract executes token swaps between different pairs efficiently.
- **Liquidity Management:** It manages liquidity pools, allowing users to add or remove liquidity for various pairs.

By interacting with the Router Contract, users can execute swaps between tokens, add liquidity to pools, and perform various other decentralized finance (DeFi) operations on platforms like PancakeSwap.

Both the Factory and Router contracts are essential components of decentralized exchanges, enabling the creation of trading pairs and the seamless execution of token swaps and liquidity management. They form the backbone of the functionalities provided by platforms like PancakeSwap on the Binance Smart Chain.

## Documentation Reference

For detailed documentation on PancakeSwap's contracts and their functionalities, refer to the following:

- **PancakeSwap Factory Contract:** [Link to Factory Contract Documentation](https://docs.pancakeswap.finance/developers/smart-contracts/pancakeswap-exchange/v2-contracts/factory-v2)
- **PancakeSwap Router Contract:** [Link to Router Contract Documentation](0x10ED43C718714eb63d5aA57B78B54704E256024E)

These references provide in-depth information on the functions and usage of PancakeSwap's contracts, which are utilized in this project for token swapping calculations.
