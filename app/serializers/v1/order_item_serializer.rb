class V1::OrderItemSerializer < V1::BaseSerializer
  attributes :id

  has_one :item, serializer: V1::ItemSerializer
end
