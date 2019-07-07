require 'rspec'
require './checkout'

describe Checkout do
  before do
    PromotionalRule.initialize_from_config
    Product.initialize_from_config
  end

  let(:promotional_rules) { PromotionalRule.all }
  let(:co) { Checkout.new(promotional_rules) }

  describe 'the total value' do
    let(:item_001) { '001' }
    let(:item_002) { '002' }
    let(:item_003) { '003' }

    it 'has the checkout discount' do
      co.scan(item_001)
      co.scan(item_002)
      co.scan(item_003)

      expect(co.total).to eq '£66.78'
    end

    it 'has the item discount' do
      co.scan(item_001)
      co.scan(item_003)
      co.scan(item_001)

      expect(co.total).to eq '£36.95'
    end

    it 'has the checkout and item discounts' do
      co.scan(item_001)
      co.scan(item_002)
      co.scan(item_001)
      co.scan(item_003)

      expect(co.total).to eq '£73.76'
    end
  end
end
