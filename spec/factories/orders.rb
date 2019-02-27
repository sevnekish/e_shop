# == Schema Information
#
# Table name: orders
#
#  id         :bigint(8)        not null, primary key
#  discount   :integer          default(0), not null
#  total      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :order do
    total { 100..600 }
    discount { 0 }
  end

  trait :simple_order do
    after(:create) do |order|
      item_1 = create :item, price: 120
      item_2 = create :item, price: 300
      item_3 = create :item, price: 100

      oi_1 = create :order_item, order: order, item: item_1, quantity: 3
      oi_2 = create :order_item, order: order, item: item_2, quantity: 2
      oi_3 = create :order_item, order: order, item: item_3, quantity: 4

      order.update(total: 1360)
    end
  end
end
