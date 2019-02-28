require 'rails_helper'

RSpec.describe V1::ItemsController, type: :controller do
  describe 'GET #index' do
    let!(:item_1) { create :item }
    let!(:item_2) { create :item }

    subject { get :index }

    it { is_expected.to have_http_status :ok }

    it 'responds with serialized collection of items' do
      subject
      expect(json_response[:items]).to match_array(
        [
          {
            id: item_1.id,
            title: item_1.title,
            category: item_1.category,
            color: item_1.color,
            price: item_1.price,
            quantity: item_1.quantity
          },
          {
            id: item_2.id,
            title: item_2.title,
            category: item_2.category,
            color: item_2.color,
            price: item_2.price,
            quantity: item_2.quantity
          }
        ]
      )
    end
  end
end
