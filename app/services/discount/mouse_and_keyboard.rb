# discount for mouse + keyboard
class Discount::MouseAndKeyboard < Discount::Base
  AMOUNT = 3

  def applicable?
    total_quantity == 2 && from_categories?(%w(mouse keyboard))
  end
end
