class Order::Create
  attr_reader :order

  def initialize(order_items)
    @order = Order::Build.call(order_items)
  end
  
  def perform
    apply_discount
    validate_order
    create_order
  end

  private
  
  def apply_discount
    discount = Order::CalculateDiscount.new(order).perform
    return if discount == 0
    
    order.total = (order.total * (1 - discount/100)).round
    order.discount
  end

  def validate_order
    Order::Validate.new(order).perform
  end

  def create_order
    return order if order.errors.any?
    order.save
    order
  end
end
