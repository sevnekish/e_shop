class Order::Validate
  # TODO: refactor with dry-validation
  attr_reader: :order

  def initialize(order)
    @order = order
  end

  def perform
    order.order_items.each do |order_item|
      next if order_item.quantity <= order_item.item.quantity
      order.errors.add(:order_items, "#{order_item.item.title} out of stock")
    end
  end
end
