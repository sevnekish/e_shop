class V1::ItemsController < V1::BaseController
  def index
    items = Item.all

    respond_with_serialized_list_for(
      items,
      each_serializer: V1::ItemSerializer
    )
  end
end
