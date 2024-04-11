class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create]
  def index
    @orders = Order.all
  end

  def show
    set_order
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      flash[:notice] = 'Pedido cadastrado com sucesso'
      redirect_to @order
    else
      flash.now[:notice] = 'Não foi possível cadastrar o pedido'
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      render 'new'
    end
  end

  private

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
