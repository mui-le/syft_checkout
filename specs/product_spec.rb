require 'rspec'
require './product'

describe Product do
  before do
    Product.initialize_from_config
  end

  let(:products) { Product.all }

  describe 'loads from configuration' do
    it 'has the correct number of records' do
      expect(products.count).to eq 3
    end
  end

  describe 'creates the object' do
    it 'responds to readers' do
      product = Product.new({'id':2,'code': 2,'name': 'item','price': 2})

      expect(product).to have_attributes(id: 2,code: 2,name: 'item',price: 2)
    end

    describe 'class methods' do
      it 'responds to all' do
        products = Product.all
        expect(products.count).to be > 1
      end

      it 'responds to find' do
        product = Product.find(1)
        expect(product.id).to eq(1)
      end
    end

    describe 'instance methods' do
      it 'gets the code and price' do
        product = Product.find(1)
        expect(product.code_and_price).to eq(['001',925])
      end
    end
  end
end
