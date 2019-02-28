require 'rails_helper'

RSpec.describe Discount::FoodAfterSix do
  describe '.applicable?' do
    let(:category_1) { :food }
    let(:category_2) { :food }
    let!(:item_1) { create :item, price: 100, category: category_1 }
    let!(:item_2) { create :item, price: 200, category: category_2 }
    let!(:order_item_1) { build :order_item, item: item_1 }
    let!(:order_item_2) { build :order_item, item: item_2 }

    let(:order) do
      double :order, order_items: [
        order_item_1,
        order_item_2
      ]
    end

    let(:time) { Time.parse('06:00 pm') + 1.minute }

    subject { described_class.new(order).applicable? }

    before do
      Timecop.freeze(time)
    end

    after do
      Timecop.return
    end

    it 'returns true' do
      expect(subject).to be_truthy
    end

    context 'when items from different categories' do
      let(:category_2) { :mouse }

      it 'returns false' do
        expect(subject).to be_falsey
      end
    end

    context 'when time before 06:00 p.m.' do
      let(:time) { Time.parse('06:00 pm') - 1.minute }

      it 'returns false' do
        expect(subject).to be_falsey
      end
    end
  end
end
