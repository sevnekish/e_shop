class Discount::Base
  attr_reader :order_items

  def initialize(order_items)
    @order_items = order_items
  end

  def is_applicable?; end

  protected

  def total_quantity
    order_items.inject(0) { |sum, ord_item| sum + ord_item.quantity }
  end

  def from_categories?(categories)
    (order_items.map(&:item).pluck(:category).uniq  - [*categories]) == []
  end
end