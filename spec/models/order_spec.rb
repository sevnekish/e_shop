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

require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to have_many(:order_items) }  
  it { is_expected.to have_many(:items).through(:order_items) }
end
