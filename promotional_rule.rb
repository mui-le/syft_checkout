# frozen_string_literal: true
#
# Promotional rule is an abstraction to represent a single "promotional rule
# class", say if "the spend is over £60 then apply 10% discount".
#
# These rules are pre-filled during development, so no DB storage required,
# we just create in-memory objects and address them the usual way:
#
#   rule  = PromotionalRule.find `some_id`
#   rules = PromotionalRule.all
#
# Each rule has the following attributes:
#
# - id: a string
#
# - type: if it's applied to the entire `cart` of to a specific `item`
#
# - requirement: the minumim amount of sterlings in the cart (for cart type) or
#                the minimum amount of items if the discount is item type
#
# - item_id: in case the rule type is `item` this field is needed to specify
#            which item the discount will be applied
#
# - discount_percentage: the percentage of discount applied
#
# - discount_amount: the amount of discount applied in cents
#
#

require './lib/file_record/file_yaml'

class PromotionalRule < FileRecord::FileYaml
  DEFAULT_CONFIG_PATH = ['','app','config','promotional_rules.yml'].join('/')
  @records = {}

  attr_reader :id, :type, :requirement, :item_id,
              :discount_percentage, :discount_amount

  def initialize(params)
    @id,
    @type,
    @requirement,
    @item_id,
    @discount_percentage,
    @discount_amount = params.values_at(:id,
                                        :type,
                                        :requirement,
                                        :item_id,
                                        :discount_percentage,
                                        :discount_amount)
    freeze
  end

  def self.config_path
    DEFAULT_CONFIG_PATH
  end
end
