// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "./interfaces/IERC20.sol";
import "./interfaces/IUniswapV2Pair.sol";
import "./interfaces/IUniswapV2Factory.sol";
import "./interfaces/IUniswapV2Router01.sol";
import "./interfaces/IUniswapV2Router02.sol";
import "./libraries/UniswapV2Library.sol";
import "./libraries/SafeERC20.sol";

contract FlashLoan {
    // Factory and Routing Addresses. For optimization used private and constant to reduce gas cost
    address private constant PANCAKE_FACTORY =
        0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73;
    address private constant PANCAKE_ROUTER =
        0x10ED43C718714eb63d5aA57B78B54704E256024E;

    // Token Addresses
    address private constant BUSD = 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56;
    address private constant WBNB = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
    address private constant CROX = 0x2c094F5A7D1146BB93850f629501eB749f6Ed491;
    address private constant CAKE = 0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82;

    uint256 private deadline = block.timestamp + 1 days;
    uint256 private constant MAX_INT =
        115792089237316195423570985008687907853269984665640564039457584007913129639935;

    function initArbitrage(address _borrowedToken, uint _borrowAmount) {
        // Allow our account to spend BUSD, CROX and CAKE
        IERC20(BUSD).safeApprove(address(PANCAKE_ROUTER), MAX_INT);
        IERC20(CROX).safeApprove(address(PANCAKE_ROUTER), MAX_INT);
        IERC20(CAKE).safeApprove(address(PANCAKE_ROUTER), MAX_INT);

        // This will give me address for the liquidity pool between two pair of tokens
        address pair = IUniswapV2Factory(PANCAKE_FACTORY).getPair(
            _borrowedToken,
            WBNB
        );

        // If liquidity pool does not exist, then revert the transaction
        require(pair != address(0), "This pool does not exist");

        // Fetching the mutiple token address of the pair
        address token0 = IUniswapV2Pair(pair).token0();
        address token1 = IUniswapV2Pair(pair).token1();

        // Check which one is the token we want to borrow
        uint amount0Out = _borrowedToken == token0 ? _borrowAmount : 0;
        uint amount1Out = _borrowedToken == token1 ? _borrowAmount : 0;

        bytes memory data = abi.encode(
            _borrowedToken,
            _borrowAmount,
            msg.sender
        );

        // Here, I am transfering the borrowed token to this flash loan contract
        IUniswapV2Pair(pair).swap(amount0Out, amount1Out, address(this), data);
    }

    function pancakeCall(
        address _sender,
        uint _amount0,
        uint _amount1,
        bytes1 calldata _data
    ) external {
        address token0 = IUniswapV2Pair(msg.sender).token0();
        address token1 = IUniswapV2Pair(msg.sender).token1();

        address pair = IUniswapV2Factory(PANCAKE_FACTORY).getPair(
            token0,
            token1
        );
        require(msg.sender == pair, "Pair doen't match");
        require(_sender == address(this), "Sender doen't match");

        (address busdBorrowed, uint amount, address borrower) = abi.decode(
            _data,
            (address, uint, address)
        );
    }
}
