require 'rails_helper'

RSpec.describe Order::Create do
  describe '#perform!' do
    let(:quantity_1) { 2 }
    let(:quantity_2) { 3 }
    let!(:item_1) { create :item, price: 100, quantity: quantity_1 }
    let!(:item_2) { create :item, price: 200, quantity: quantity_2 }
    let(:item_id_1) { item_1.id }
    let(:item_id_2) { item_2.id }
    let(:order_params) do
      { 
        order_items: [
          { item_id: item_id_1, quantity: 2 },
          { item_id: item_id_2, quantity: 1 }
        ]
      }
    end
    let(:discount) { 0 }

    subject { Order::Create.new(order_params).perform! }
    
    before do
      allow(Order::CalculateDiscount)
        .to receive(:call)
        .and_return(discount)
    end


    it 'creates new order' do
      expect(subject).to be_persisted
      expect(subject.total).to eq(400)
      expect(subject.discount).to eq(0)
      expect(subject.order_items.count).to eq(2)
    end

    it 'updates quantity of ordered items' do
      subject
      expect(item_1.reload.quantity).to eq(0)
      expect(item_2.reload.quantity).to eq(2)
    end

    context 'when discount is applayed' do
      let(:discount) { 50 }

      it 'creates new order with discount' do
        expect(subject).to be_persisted
        expect(subject.total).to eq(200)
        expect(subject.discount).to eq(50)
        expect(subject.order_items.count).to eq(2)
      end
  
      it 'updates quantity of ordered items' do
        subject
        expect(item_1.reload.quantity).to eq(0)
        expect(item_2.reload.quantity).to eq(2)
      end
    end

    context 'when params are invalid' do
      let(:quantity_1) { 0 }

      it 'raises an exception with appropriate message' do
        expect { subject }.to raise_error(Exception::RecordInvalidError)
      end
    end
  end
end