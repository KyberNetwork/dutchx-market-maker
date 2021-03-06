pragma solidity 0.5.2;


import "./ERC20Interface.sol";
import "./PermissionGroups.sol";


/**
 * @title Contracts that should be able to recover tokens or ethers
 * @author Ilan Doron
 * @dev This allows to recover any tokens or Ethers received in a contract.
 * This will prevent any accidental loss of tokens.
 */
contract Withdrawable is PermissionGroups {

    event TokenWithdraw(
        ERC20 indexed token,
        uint amount,
        address indexed sendTo
    );

    /**
     * @dev Withdraw all ERC20 compatible tokens
     * @param token ERC20 The address of the token contract
     */
    function withdrawToken(
      ERC20 token,
      uint amount,
      address sendTo
    )
        external
        onlyAdmin
    {
        require(token.transfer(sendTo, amount), "Could not transfer tokens");
        emit TokenWithdraw(token, amount, sendTo);
    }

    event EtherWithdraw(
        uint amount,
        address indexed sendTo
    );

    /**
     * @dev Withdraw Ethers
     */
    function withdrawEther(
        uint amount,
        address payable sendTo
    )
        external
        onlyAdmin
    {
        sendTo.transfer(amount);
        emit EtherWithdraw(amount, sendTo);
    }
}
