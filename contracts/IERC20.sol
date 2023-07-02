// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf( address amount) external view  returns (uint);
}