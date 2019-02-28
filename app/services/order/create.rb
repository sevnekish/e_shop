class Order::Create
  attr_reader :order_params, :order

  def initialize(order_params)
    @order_params = order_params
  end

  def perform!
    prepare_params!
    initialize_form
    validate_params!
    define_total
    apply_discount
    persist_order
    update_ordered_items_quantity
    order.model
  end

  private

  def prepare_params!
    order_params[:order_items].map! do |oi|
      { item: Item.find(oi[:item_id]), quantity: oi[:quantity].to_i }
    end
    order_params[:total] = 0
    order_params[:discount] = 0
  end

  def initialize_form
    @order = OrderForm.new(Order.new)
  end

  def validate_params!
    return if order.validate(order_params)

    raise Exception::RecordInvalidError.new(order.errors.messages)
  end

  def define_total
    order.total = order.order_items.inject(0) { |sum, oi| sum + oi.item.price * oi.quantity }
  end

  def apply_discount
    discount = Order::CalculateDiscount.call(order)
    return if discount.zero?

    order.total = (order.total * (1.0 - discount / 100.0)).round
    order.discount = discount
  end

  def persist_order
    order.save
  end

  def update_ordered_items_quantity
    order.order_items.each do |oi|
      item = oi.item
      # TODO: move to a separate operation
      item.update(quantity: item.quantity - oi.quantity)
    end
  end
end
