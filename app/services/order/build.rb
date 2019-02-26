class Order::Build
  def self.call(order_items)
    Order.build do |order|
      total = 0

      order_items.each do |oi|
        item = Item.find(oi[:item_id]
        order.order_items << OrderItem.new(item: item, quantity: oi[:quantity]))
        total += item.price * oi[:quantity]
      end

      order.total = total
      order.discount = 0
    end
  end
end
