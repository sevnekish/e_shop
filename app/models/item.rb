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

class Item < ActiveRecord::Base
  enum category: %i[food mouse keyboard]
  enum color: %i[white black red]

  has_many :order_items
  has_many :orders, through: :order_items
end
