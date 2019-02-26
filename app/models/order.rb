# == Schema Information
#
# Table name: orders
#
#  id         :bigint(8)        not null, primary key
#  total      :integer          not null
#  discount   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ActiveRecord::Base
  has_many :order_items
  has_many :items, through: :order_items
end
