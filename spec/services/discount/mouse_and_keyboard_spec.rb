require 'rails_helper'

RSpec.describe Discount::MouseAndKeyboard do
  describe '.applicable?' do
    let(:category_1) { :mouse }
    let(:category_2) { :keyboard }
    let!(:item_1) { create :item, price: 100, category: category_1 }
    let!(:item_2) { create :item, price: 200, category: category_2 }
    let(:quantity_1) { 1 }
    let(:quantity_2) { 1 }
    let!(:order_item_1) { build :order_item, item: item_1, quantity: quantity_1 }
    let!(:order_item_2) { build :order_item, item: item_2, quantity: quantity_2 }

    let(:order) do
      double :order, order_items: [
        order_item_1,
        order_item_2
      ]
    end

    subject { described_class.new(order).applicable? }

    it 'returns true' do
      expect(subject).to be_truthy
    end

    context 'when items from different categories' do
      let(:category_2) { :food }

      it 'returns false' do
        expect(subject).to be_falsey
      end
    end

    context 'when total quantity is differs from 2' do
      let(:quantity_1) { 2 }

      it 'returns false' do
        expect(subject).to be_falsey
      end
    end
  end
end
