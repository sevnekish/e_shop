# == Schema Information
#
# Table name: order_items
#
#  id       :bigint(8)        not null, primary key
#  quantity :integer          not null
#  item_id  :bigint(8)
#  order_id :bigint(8)
#
# Indexes
#
#  index_order_items_on_item_id               (item_id)
#  index_order_items_on_order_id              (order_id)
#  index_order_items_on_order_id_and_item_id  (order_id,item_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (order_id => orders.id)
#

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:item) }
end
