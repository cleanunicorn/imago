pragma solidity >= 0.6.0;

import "../Imago.sol";


contract ImagoShouldReturnTrue {
    Imago private _imago;

    constructor(
        string memory name,
        string memory symbol,
        uint totalSupply,
        uint granularity,
        address[] memory defaultOperators
    ) public {
        _imago = new Imago(name, symbol, totalSupply, granularity, defaultOperators);
    }

    function transfer(address _recipient, uint _amount)
        public
        returns (bool)
    {
        bool result = _imago.transfer(_recipient, _amount);

        require(result == true, "Should return true on successful transfer.");

        return result;
    }
}
