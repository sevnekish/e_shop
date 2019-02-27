# == Schema Information
#
# Table name: items
#
#  id         :bigint(8)        not null, primary key
#  category   :integer          not null
#  color      :integer          not null
#  price      :integer          not null
#  quantity   :integer          default(0), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :item do
    title { Faker::Name.name }
    category { Item.categories.keys.sample }
    color { Item.colors.keys.sample }
    price { rand 100..20000 }
  end
end
