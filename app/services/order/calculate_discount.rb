class Order::CalculateDiscount
  DISCOUNTS = [
    Discount::FoodAfterSix,
    Discount::MouseAndKeyboard,
    Discount::TenWhite
  ]

  attr_reader: :order

  def initialize(order)
    @order = order
  end
  
  def perform
    amount = 0

    DISCOUNTS.each do |discount|
      next unless discount.new(order.order_items).is_applicable?
      amount += discount::AMOUNT
    end

    amount
  end
end
