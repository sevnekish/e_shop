class V1::OrdersController < V1::BaseController
  def create
    order = Order::Create.new(order_params).perform!
    respond_with_serialized_resource_for(order, status: :created)
  end

  private

  def order_params
    params.require(:order).permit(order_items: [:item_id, :quantity])
  end
end
