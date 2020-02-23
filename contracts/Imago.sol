pragma solidity >= 0.6.0;

import "./IERC777.sol";

contract Imago is IERC777 {
    string private _name;
    string private _symbol;

    address owner;

    constructor(
        string memory name,
        string memory symbol
    ) public {
        owner = msg.sender;

        _name = name;
        _symbol = symbol;
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

    // function authorizeOperator() public virtual {};
}
