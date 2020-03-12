pragma solidity >= 0.6.0;

import "./IERC777.sol";

contract Imago is IERC777 {
    string private _name;
    string private _symbol;
    uint private _totalSupply;

    address public owner;

    // Keeps track of the each actor's balances
    mapping(address => uint256) private _balances;


    constructor(
        string memory name,
        string memory symbol,
        uint totalSupply
    ) public {
        // Set the owner
        owner = msg.sender;

        // Set basic information about the token
        _name = name;
        _symbol = symbol;
        _totalSupply = totalSupply;

        // Add all of the tokens to the owner;
        _balances[msg.sender] = totalSupply;
    }

    function name()
        public
        override(IERC777)
        view
        returns (string memory)
    {
        return _name;
    }

    function symbol()
        public
        override(IERC777)
        view
        returns (string memory)
    {
        return _symbol;
    }

    function totalSupply()
        public
        override(IERC777)
        view
        returns (uint)
    {
        return _totalSupply;
    }

    function balanceOf(address holder)
        public
        override(IERC777)
        view
        returns (uint)
    {
        return _balances[holder];
    }

    function transfer(address recipient, uint amount)
        public
        returns (bool)
    {
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;

        return true;
    }
}
