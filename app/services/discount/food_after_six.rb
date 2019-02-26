# discount for food ordered after 6 p.m.
class Discount::FoodAfterSix < Discount::Base
  AMOUNT = 5
  
  def is_applicable?
    from_categories?('food') && after_six?
  end

  private

  def after_six?
    Time.now.hour >= 18
  end
end