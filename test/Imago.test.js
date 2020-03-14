const {
    accounts,
    contract
} = require('@openzeppelin/test-environment')
const {
    expect
} = require('chai')

const {
    BN
} = require('@openzeppelin/test-helpers')

const Imago = contract.fromArtifact('Imago')

const name = 'Imago'
const symbol = 'IMG'
const initialSupply = new BN('10000')
const granularity = new BN('1')

const [owner, accountA, accountB, operatorA, operatorB] = accounts

const defaultOperators = [operatorA, operatorB]

const ImagoShouldReturnTrue = contract.fromArtifact('ImagoShouldReturnTrue')

describe('Imago', () => {
    beforeEach(async () => {
        this.imago = await Imago.new(name, symbol, initialSupply, granularity, defaultOperators, {
            from: owner
        })
    })

    context('deploy with basic information', () => {
        it('returns the name', async () => {
            expect(await this.imago.name()).to.equal(name)
        })

        it('returns the symbol', async () => {
            expect(await this.imago.symbol()).to.equal(symbol)
        })

        it('returns the total supply', async () => {
            expect(await this.imago.totalSupply()).to.be.bignumber.equal(initialSupply)
        })

        it('returns the granularity', async () => {
            expect(await this.imago.granularity()).to.be.bignumber.equal(granularity)
        })
    })

    context('balanceOf', () => {
        it('returns all tokens for owner', async () => {
            expect(await this.imago.balanceOf(owner)).to.be.bignumber.equal(initialSupply)
        })

        it('returns zero balance for accounts with no tokens', async () => {
            expect(await this.imago.balanceOf(accountA)).to.be.bignumber.equal(new BN(0))
        })
    })

    context('transfer', () => {
        it('tokens are moved', async () => {
            expect(await this.imago.balanceOf(accountA)).to.be.bignumber.equal('0')
            await this.imago.transfer(accountA, initialSupply, {
                from: owner
            })
            expect(await this.imago.balanceOf(owner)).to.be.bignumber.equal('0')
            expect(await this.imago.balanceOf(accountA)).to.be.bignumber.equal(initialSupply)
        })

        it('returns true on success', async () => {
            const shouldReturnTrue = await ImagoShouldReturnTrue.new(name, symbol, initialSupply, granularity, defaultOperators, {
                from: owner
            })
            await shouldReturnTrue.transfer(accountA, initialSupply, {
                from: owner
            })
        })
    })

    context('operators', () => {
        context('default operators', () => {
            it('returns default operators', async () => {
                expect(await this.imago.defaultOperators()).to.deep.equal(defaultOperators)
            })

            it('default operators are defined as an operator for any account', async () => {
                expect(await this.imago.isOperatorFor(operatorA, accountA)).to.equal(true)
            })
        })
    })
})
