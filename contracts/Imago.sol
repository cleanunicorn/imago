pragma solidity >= 0.6.0;

import "./IERC777.sol";


contract Imago is IERC777 {
    string private _name;
    string private _symbol;
    uint private _totalSupply;
    uint private _granularity;

    // Keep track of default operators
    address[] private _defaultOperatorsArray;
    mapping(address => bool) private _defaultOperators;

    // Operators
    mapping(address => mapping(address => bool)) private _operators;

    address public owner;

    // Keeps track of the each actor's balances
    mapping(address => uint256) private _balances;


    constructor(
        string memory name,
        string memory symbol,
        uint totalSupply,
        uint granularity,
        address[] memory defaultOperators
    ) public {
        // Set the owner
        owner = msg.sender;

        // Set basic information about the token
        _name = name;
        _symbol = symbol;
        _totalSupply = totalSupply;
        _granularity = granularity;

        // Set default operators
        _defaultOperatorsArray = defaultOperators;
        for (uint i = 0; i < _defaultOperatorsArray.length; i++) {
            _defaultOperators[_defaultOperatorsArray[i]] = true;
        }

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

    function granularity()
        public
        override(IERC777)
        view returns (uint)
    {
        return _granularity;
    }

    function balanceOf(address holder)
        public
        override(IERC777)
        view
        returns (uint)
    {
        return _balances[holder];
    }

    /*
    - [ ] Emit event
    - [ ] Add safe math
    - [ ] Run callback functions
    */
    function transfer(address recipient, uint amount)
        public
        returns (bool)
    {
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;

        return true;
    }

    function defaultOperators()
        public
        override(IERC777)
        view
        returns (address[] memory)
    {
        return _defaultOperatorsArray;
    }

    function isOperatorFor(
        address operator,
        address holder
    )
        public
        override(IERC777)
        view
        returns (bool)
    {
        if (_defaultOperators[operator]) {
            return true;
        }

        if (_operators[holder][operator]) {
            return true;
        }

        return false;
    }

    function authorizeOperator(
        address operator
    )
        public
        override(IERC777)
    {
        require(operator != msg.sender, "ERC777: authorizing self as operator");

        _operators[msg.sender][operator] = true;

        emit AuthorizedOperator(operator, msg.sender);
    }
}
