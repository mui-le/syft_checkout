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
    '£' + total_amount.to_s
  end

  def total_amount
    total_amount_without_discount + amounts_with_discount.sum()
  end

  def amounts_with_discount
    @promotional_rules.map do |rule|
      rule.type == 'cart' ? cart_discount(rule) : item_discount(rule)
    end
  end

  def cart_discount(rule)
    discount(rule) if total_amount_without_discount >= rule.requirement
  end

  def item_discount(rule)
    0
  end

  def total_amount_without_discount
    @products.inject(0){|acc,item| acc += item[1]}
  end

  def discount(rule)
    percent_discount(rule) + amount_discount(rule)
  end

  def percent_discount(rule)
    - (total_amount_without_discount * rule.discount_percentage)
  end

  def amount_discount(rule)
    0
  end
end
