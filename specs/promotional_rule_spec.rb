require 'rspec'
require './promotional_rule'

describe PromotionalRule do
  before do
    PromotionalRule.initialize_from_config
  end

  let(:promotional_rules) { PromotionalRule.all }

  describe 'loads the records' do
    it 'has the correct number of records' do
      expect(promotional_rules.count).to eq 3
    end
  end

  describe 'creates the object' do
    it 'responds to readers' do
      rule = PromotionalRule.new({'id': 3,
                                  'type': 'item',
                                  'requirement': 2,
                                  'item_id': '002',
                                  'discount_percentage': 0,
                                  'discount_amount': 0.75,
                                  'discount_free_item': 1
                                  })

      expect(rule).to have_attributes(id: 3,
                                      type: 'item',
                                      requirement: 2,
                                      item_id: '002',
                                      discount_percentage: 0,
                                      discount_amount: 0.75,
                                      discount_free_item: 1
                                    )
    end

    describe 'class methods' do
      it 'responds to all' do
        rules = PromotionalRule.all
        expect(rules.count).to be > 1
      end

      it 'responds to find' do
        rule = PromotionalRule.find(1)
        expect(rule.id).to eq(1)
      end
    end
  end
end
