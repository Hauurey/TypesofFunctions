# PokemonCoin Smart Contract
## Description
This project demonstrates the implementation of an ERC20-compliant token called PokemonCoin (PC). It builds upon OpenZeppelin's robust libraries to provide advanced features like safe arithmetic operations and secure token transfers. The contract includes functionality to mint, burn, and transfer tokens, while enforcing a hard cap on the total token supply. It also introduces an admin-only access control mechanism to manage specific operations, ensuring restricted actions are performed securely.

This example serves as an excellent foundation for building advanced token contracts on the Ethereum blockchain.

## Features
1. ERC20 Compliant: PokemonCoin adheres to the ERC20 standard, ensuring compatibility with existing tools and platforms.
2. Admin Control: Certain actions, such as minting tokens, are restricted to the admin account for enhanced security.
3. Hard Supply Cap: A maximum token supply of 10,000 ensures the total supply remains limited.
4. Secure Token Operations: Includes minting, burning, and transferring of tokens with built-in safeguards to prevent overflows and unauthorized actions.

## Getting Started
### Executing the Program
To run this program, you can use Remix, an online Solidity IDE. Follow these steps to get started:

Go to the Remix website: https://remix.ethereum.org/.
Create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., PokemonCoin.sol) and paste the following code into it:
Copy and paste the following code into the file:
```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract PokemonCoin is ERC20 {
    address public admin;
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
```

- Compile the Contract
* Navigate to the Solidity Compiler tab.
* Ensure the compiler version is set to 0.8.18 or compatible.
* Click Compile PokemonCoin.sol.

- Deploy the Contract
* Go to the Deploy & Run Transactions tab.
* Select the PokemonCoin contract from the dropdown.
* Deploy the contract by specifying an initial token amount for minting (e.g., 1000) in the constructor.

- Interact with the Contract
* Use the mintTokens function to create new tokens (admin only).
* Transfer tokens with transferTokens.
* Burn tokens using burnTokens (public access).

## Contract Functions
### Public Variables
admin: Address of the admin with special permissions.
MAX_TOKEN_SUPPLY: The hard cap for the total token supply (10,000).

### Modifiers
* onlyAdmin: Restricts a function's execution to the admin account.
* withinSupplyLimit: Ensures minting does not exceed the maximum token supply.

## Core Functions
### Mint Tokens
* Function: mintTokens(address recipient, uint256 amount)
* Admin-only function to mint new tokens within the supply cap.

### Transfer Tokens
* Function: transferTokens(address recipient, uint256 amount)
* Standard ERC20 transfer functionality.

### Burn Tokens
* Function: burnTokens(address account, uint256 amount)
* Reduces the token supply by burning tokens from an account.

## Authors
Metacrafter Haurrey

## License
This project is licensed under the MIT License - see the LICENSE.md file for details.
