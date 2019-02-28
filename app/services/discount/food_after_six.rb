# discount for food ordered after 6 p.m.
class Discount::FoodAfterSix < Discount::Base
  AMOUNT = 5
  
  def is_applicable?
    from_categories?('food') && after_six_pm?
  end

  private

  def after_six_pm?
    Time.parse("06:00 pm") < Time.now
  end
end