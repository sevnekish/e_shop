class OrderForm < Reform::Form
  property :total
  property :discount

  collection :order_items, populator: -> (collection:, **) {
    collection.append(OrderItem.new)
  } do
    property :item
    property :quantity

    validation do
      configure do
        def self.messages
          super.merge(
            en: { errors: { item_in_stock: 'item out of stock' } }
          )
        end
      end

      required(:item).filled
      required(:quantity).filled

      validate(item_in_stock: [:item, :quantity]) do |item, quantity|
        item.quantity >= quantity
      end
    end
  end

  validation do
    required(:order_items).filled
  end
end