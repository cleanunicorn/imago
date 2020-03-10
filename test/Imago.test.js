const { accounts, contract } = require('@openzeppelin/test-environment')
const { expect } = require('chai')

const {
    shouldBehaveLikeERC20,
} = require('./ERC20/ERC20.behavior');

const { BN } = require('@openzeppelin/test-helpers')

const Imago = contract.fromArtifact('Imago')

const initialSupply = new BN('10000');
const name = 'Imago'
const symbol = 'IMG'

describe('Imago', () => {
    beforeEach(async () => {
        this.imago = await Imago.new(name, symbol)
    })

    context('ERC20', () => {
        const [ holder, defaultOperatorA, anyone ] = accounts;
        shouldBehaveLikeERC20('ERC777', initialSupply, holder, anyone, defaultOperatorA);
    })

    context('deploy', () => {
        it('returns the name', async () => {
            expect(await this.imago.name()).to.equal(name)
        })

        it('returns the symbol', async () => {
            expect(await this.imago.symbol()).to.equal(symbol)
        })
    })

    expect(true)
})
