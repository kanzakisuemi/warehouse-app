class OrderItemsController < ApplicationController
  before_action :set_order

  def new
    @order_item = OrderItem.new
    @products = @order.supplier.product_models
  end

  def create
    @order.order_items.create(order_item_params)
    redirect_to @order, notice: 'Item adicionado com sucesso!'
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_model_id)
  end
end
