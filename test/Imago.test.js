const { contract } = require('@openzeppelin/test-environment')
const { expect } = require('chai')

require('@openzeppelin/test-helpers')

const Imago = contract.fromArtifact('Imago')

const name = 'Imago'
const symbol = 'IMG'

describe('Imago', () => {
    beforeEach(async () => {
        this.imago = await Imago.new(name, symbol)
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
