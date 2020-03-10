pragma solidity >= 0.6.0;

import "./IERC777.sol";

contract Imago is IERC777 {
    string private _name;
    string private _symbol;
    uint private _totalSupply;

    address public owner;


    constructor(
        string memory name,
        string memory symbol,
        uint totalSupply
    ) public {
        owner = msg.sender;

        _name = name;
        _symbol = symbol;
        _totalSupply = totalSupply;
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

    // function authorizeOperator() public virtual {};
}
