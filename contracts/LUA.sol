// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import "./IERC20.sol";

contract LUA {
    IERC20 public immutable token0;
    IERC20 public immutable token1;

    uint256 public reserve0;
    uint256 public reserve1;
    uint256 public totalSupply;
   
    mapping(address => uint256) public balanceOf;

    constructor(address _token0, address _token1) {
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
    }

    function _mint(address _to, uint256 _amount) private {
        // Mint Shares

        balanceOf[_to] += _amount;
        totalSupply += _amount;
    }

    function _burn(address _from, uint256 _amount) private {
        // burn shares

        balanceOf[_from] -= _amount;
        totalSupply -= _amount;
    }

    function 

    function swap(address _tokenIn, uint256 _amountIn)
        external
        returns (uint256 amountOut)
    {
        require(
            _tokenIn == address(token0) || _tokenIn == address(token1),
            "Invalide Token"
        );
        require(_amountIn > 0, "amount in = 0");

        // calcuate the token  out (include Fees)
        bool isToken0 = _tokenIn == address(token0);
        (
            IERC20 tokenIn,
            IERC20 tokenOut,
            uint reserveIn,
            uint reserveOut
        ) = isToken0 
        ? (token0, token1, reserve0 , reserve1 ) 
        : (token1, token0 , reserve0 , reserve1);

        tokenIn.transferFrom(msg.sender, address(this), _amountIn);

        uint amountInWithFee = (_amountIn * 1000) / 1003;
        amountOut = (resrveOut * amountInWithFee) / (reserveIn + amountInWithFee);
        tokenOut.transfer(msg.sender, amountOut);
        // Transfer Token out to msg.sendre
        // update the reserves

        // abx / (x  + bx) = ba calcualte ammount of token goes out
    }

    function addLiquidity() external {}

    function removeLiquidity() external {}
}
