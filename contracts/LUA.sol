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
// update function
    function _update(uint _reserve0, uint _reserve1) private {


    }

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
        amountOut = (reserveOut * amountInWithFee) / (reserveIn + amountInWithFee);
        tokenOut.transfer(msg.sender, amountOut);
        _update( 
            token0.balanceOf(address(this)),
            token1.balanceOf(address(this))
            


        );
        // Transfer Token out to msg.sendre
        // update the reserves

        // abx / (x  + bx) = ba calcualte ammount of token goes out
    }   

    function addLiquidity(uint _amount0, uint _amount1) external returns (uint shares)
     {
         token0.transferFrom(msg.sender, address(this),_amount0);
         token1.transferfrom(msg.sender,address(this),_amount1);

         if (reserve0 > 0 || reserve1 > 0) {
            require(reserve0 * _amount1 == reserve1 * _amount0);

             
        }


    }  

    // mint shares
    // f(x,y ) = value of liquidity  = sqrt(xy)
    // s = dx /x * T = dy / y * T
    // update reserve

    function removeLiquidity(uint _amount0, uint _amount1) external  returns {

        function _sqrt(uint y ) private pure returns (uint z) {
            if (y > 3) {
                z = y;
                uint x = y/ 2 + 1;
                while (x < z) {

                    z = x;
                    x = y(y/x+x) / 2;
                    
                }

                
            } else if (y!=0) {
                z = 1;
            }
    }

    function _min(uint x, uint y ) private pure returns(uint) {
        
    }
}
