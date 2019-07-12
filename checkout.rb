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
    '£' + '%.2f' % total_amount
  end

  def total_amount
    (total_amount_without_discount + all_discounts) / 100
  end

  def all_discounts
    all_cart_discounts + all_item_discounts + cart_discount_amendment
  end

  # Cart discount
  def cart_discount_amendment
    return 0 if all_cart_discounts == 0
    ((total_amount_without_discount / all_cart_discounts) / 100 * all_item_discounts).to_i
  end

  def all_cart_discounts
    amounts_with_discount.inject(0){|a,r| a+= r.has_key?(:cart) ? r[:cart] : 0}
  end

  def cart_discount(rule)
    total_amount_without_discount >= rule.requirement ? discount(rule) : 0
  end


  # Item discount
  def all_item_discounts
    amounts_with_discount.inject(0){|a,r| a+= r.has_key?(:item) ? r[:item] : 0}
  end

  def item_discount(rule)
    items_per_code(rule.item_id) >= rule.requirement.to_i ? discount(rule) : 0
  end

  #
  def amounts_with_discount
    @promotional_rules.map do |rule|
      rule.type == 'cart' ? {cart: cart_discount(rule)} : {item: item_discount(rule)}
    end
  end


  def items_per_code(code)
    count = @products.inject(Hash.new(0)) { |h, e| h[e[0]] += 1 ; h }[code]
  end

  def total_amount_without_discount
    @products.inject(0){|acc,item| acc += item[1]}
  end

  def discount(rule)
    f = free_item_discount(rule)

    percent_discount(rule) + amount_discount(rule) + f
  end

  def percent_discount(rule)
    - (total_amount_without_discount * rule.discount_percentage).to_i
  end

  def amount_discount(rule)
    - (items_per_code(rule.item_id) * rule.discount_amount)
  end

  def free_item_discount(rule)
    # select the products matching the item_id of promotional rule and get the
    # price
    items = @products.select{|p| p[0] == rule.item_id}
    product_price = items.uniq.first&.last
    times_to_apply = items.count / rule.requirement
    product_price ? - (rule.discount_free_item * product_price * times_to_apply) : 0
  end
end
