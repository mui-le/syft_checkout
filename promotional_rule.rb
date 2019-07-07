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
# - discount_amount: the amount of discount applied
#
#

class PromotionalRule

end
