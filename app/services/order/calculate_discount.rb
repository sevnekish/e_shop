class Order::CalculateDiscount
  DISCOUNTS = [
    Discount::FoodAfterSix,
    Discount::MouseAndKeyboard,
    Discount::TenWhite
  ].freeze

  def self.call(order)
    amount = 0

    DISCOUNTS.each do |discount|
      next unless discount.new(order).applicable?

      amount += discount::AMOUNT
    end

    amount
  end
end
