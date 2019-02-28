require 'rails_helper'

RSpec.describe Discount::TenWhite do
  describe '.is_applicable?' do
    let(:color_1) { :white }
    let(:color_2) { :white }
    let!(:item_1) { create :item, price: 100, color: color_1 }
    let!(:item_2) { create :item, price: 200, color: color_2 }
    let(:quantity_1) { 2 }
    let(:quantity_2) { 8 }
    let!(:order_item_1) { build :order_item, item: item_1, quantity: quantity_1 }
    let!(:order_item_2) { build :order_item, item: item_2, quantity: quantity_2 }

    let(:order) do
      double :order, order_items: [
        order_item_1,
        order_item_2
      ]
    end

    subject { described_class.new(order).is_applicable? }

    it 'returns true' do
      expect(subject).to be_truthy
    end

    context 'when items color not white' do
      let(:color_2) { :black }

      it 'returns false' do
        expect(subject).to be_falsey
      end
    end

    context 'when total quantity differs from 10' do
      let(:quantity_1) { 1 }

      it 'returns false' do
        expect(subject).to be_falsey
      end
    end
  end
end