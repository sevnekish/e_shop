require 'rails_helper'

RSpec.describe Order::CalculateDiscount do
  describe '.call' do
    let(:order_item_1) { double :order_item_1 }
    let(:order_item_2) { double :order_item_2 }
    let(:order) do
      double :order, order_items: [
        order_item_1,
        order_item_2
      ]
    end
    let(:discount_1) { double :discount_1, applicable?: true }
    let(:discount_2) { double :discount_2, applicable?: false }
    let(:discount_3) { double :discount_3, applicable?: true }

    subject { described_class.call(order) }

    before do
      allow(Discount::FoodAfterSix)
        .to receive(:new)
        .with(order)
        .and_return(discount_1)
    end

    before do
      allow(Discount::MouseAndKeyboard)
        .to receive(:new)
        .with(order)
        .and_return(discount_2)
    end

    before do
      allow(Discount::TenWhite)
        .to receive(:new)
        .with(order)
        .and_return(discount_3)
    end

    it 'returns sum amount of applicable discounts' do
      stub_const('Discount::FoodAfterSix::AMOUNT', 5)
      stub_const('Discount::MouseAndKeyboard::AMOUNT', 3)
      stub_const('Discount::TenWhite::AMOUNT', 1)
      expect(subject).to eq(6)
    end
  end
end
