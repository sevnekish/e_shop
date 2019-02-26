# discount for ten white items
class Discount::TenWhite < Discount::Base
  AMOUNT = 1
  
  def is_applicable?
    total_quantity == 10 && only_white?
  end

  private

  def only_white?
    order_items.map(&:item).pluck(:color).uniq  == ['white']
  end
end