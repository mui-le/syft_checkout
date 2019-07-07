# frozen_string_literal: true
#
# Product is an abstraction to represent a single "product"
#
# These products are pre-filled during development, so no DB storage required,
# we just create in-memory objects and address them the usual way:
#
#   product  = Product.find 'some_id'
#   products = Product.all
#
# Each product has the following attributes:
#
# - code: a string
#
# - name: the product name
#
# - price: the minumim amount of sterlings in the cart (for cart type) or
#                the minimum amount of items if the discount is item type
#
#

require './lib/file_record/file_yaml'

class Product < FileRecord::FileYaml
  DEFAULT_CONFIG_PATH = ['','app','config','products.yml'].join('/')
  @records = {}

  attr_reader :id, :code, :name, :price

  def initialize(params)
    @id, @code, @name, @price = params.values_at(:id, :code, :name, :price)
    freeze
  end

  def self.config_path
    DEFAULT_CONFIG_PATH
  end

  ## Instance methods #########################################################

  def code_and_price
    [code,price_amount*100]
  end

  def price_amount
    price.gsub('£','').to_f
  end
end
