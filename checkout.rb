# frozen_string_literal: true
#
# This class will handle the checkout process.
#
# As per the requirement, this class will be initialized with the promotional
# rules. After the objected is instantiated it will be able to receive the scan
# method to add product items to checkout and the method total will output the
# value with the discount included
#

require './promotional_rule'
require './product'

class Checkout
  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
    @products = []
  end

  def scan(product_code)
    @products.append(Product.find_by('code',product_code).code_and_price)
  end

  def total

  end
end
