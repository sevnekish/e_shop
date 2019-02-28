class Order::CalculateDiscount
  DISCOUNTS = [
    Discount::FoodAfterSix,
    Discount::MouseAndKeyboard,
    Discount::TenWhite
  ]
  
  def self.call(order)
    amount = 0

    DISCOUNTS.each do |discount|
      next unless discount.new(order).is_applicable?
      amount += discount::AMOUNT
    end

    amount
  end
end
