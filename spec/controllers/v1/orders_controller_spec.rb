require 'rails_helper'

RSpec.describe V1::OrdersController, type: :controller do
  describe 'POST #create' do
    let!(:item_1) { create :item, price: 100, category: :food, quantity: 5, color: :white }
    let!(:item_2) { create :item, price: 200, category: :food, quantity: 10, color: :white }

    let(:time) { Time.parse('06:00 pm') + 1.minute }

    let(:quantity_2) { 5 }
    let(:item_id_1) { item_1.id }

    let(:params) do
      {
        order: {
          order_items: [
            { item_id: item_id_1, quantity: 5 },
            { item_id: item_2.id, quantity: quantity_2 }
          ]
        }
      }
    end

    subject { post :create, params: params }

    before do
      Timecop.freeze(time)
    end

    after do
      Timecop.return
    end

    it { is_expected.to have_http_status :created }

    it 'responds with serialized order' do
      subject
      expect(json_response[:order].except(:created_at)).to eq(
        total: 1410,
        discount: 6,
        order_items: [
          {
            quantity: 5,
            item: {
              id: item_1.reload.id,
              title: item_1.title,
              category: item_1.category,
              color: item_1.color,
              price: item_1.price,
              quantity: item_1.quantity
            }
          },
          {
            quantity: 5,
            item: {
              id: item_2.reload.id,
              title: item_2.title,
              category: item_2.category,
              color: item_2.color,
              price: item_2.price,
              quantity: item_2.quantity
            }
          }
        ]
      )
    end

    context 'when item does not exist' do
      let(:item_id_1) { 124 }

      it { is_expected.to have_http_status :not_found }

      it 'responds with error message' do
        subject
        expect(json_response[:error]).to eq('Item not found')
      end
    end

    context 'when item out of stock' do
      let(:quantity_2) { 20 }

      it { is_expected.to have_http_status :unprocessable_entity }

      it 'responds with error message' do
        subject
        expect(json_response[:error]).to eq('order_items.item_in_stock': ['item out of stock'])
      end
    end
  end
end
