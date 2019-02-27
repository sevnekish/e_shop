class V1::ItemSerializer < V1::BaseSerializer
  attributes :total, :discount, :created_at

  has_many :order_items, serializer: V1::OrderItemSerializer
end
