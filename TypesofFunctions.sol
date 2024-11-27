// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract PokemonCoin is ERC20 {
    address public admin;

    // Hard cap for total token supply
    uint256 public constant MAX_TOKEN_SUPPLY = 10000; 

    modifier onlyAdmin() {
        require(msg.sender == admin, "Access restricted to admin");
        _;
    }

    modifier withinSupplyLimit(uint256 amount) {
        require(totalSupply() + amount <= MAX_TOKEN_SUPPLY, "Cannot exceed max token supply");
        _;
    }

    constructor(uint256 initialAmount) ERC20("Pokemon Coin", "PC") {
        _mint(msg.sender, initialAmount);
        admin = msg.sender;
    }

    function mintTokens(address recipient, uint256 amount) external onlyAdmin withinSupplyLimit(amount) {
        _mint(recipient, amount);
    }

    function transferTokens(address recipient, uint256 amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function burnTokens(address account, uint256 amount) external {
        _burn(account, amount);
    }
}
