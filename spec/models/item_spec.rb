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

require 'rails_helper'

RSpec.describe Item, type: :model do
  it { is_expected.to have_many(:order_items) }
  it { is_expected.to have_many(:orders).through(:order_items) }
end
