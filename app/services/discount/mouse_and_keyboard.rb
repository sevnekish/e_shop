# discount for mouse + keyboard
class Discount::MouseAndKeyboard < Discount::Base
  AMOUNT = 3

  def is_applicable?
    total_quantity == 2 && from_categories?(['keyboard', 'mouse'])
  end
end