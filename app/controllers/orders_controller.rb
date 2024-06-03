class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create my search show edit update]
  before_action :set_order, only: %i[show edit update in_progress delivered canceled]
  before_action :check_user, only: %i[edit update]

  def my
    # @orders = Order.where(user: current_user)
    @orders = current_user.orders
  end

  def search
    @code = params['query']

    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def in_progress
    @order.in_progress!
    flash[:notice] = 'Pedido em andamento'
    redirect_to @order
  end

  def delivered
    @order.delivered!
    @order.order_items.each do |order_item|
      order_item.quantity.times do
        StockProduct.create!(order: @order, product_model: order_item.product_model, warehouse: @order.warehouse)
      end
    end
    flash[:notice] = 'Pedido entregue'
    redirect_to @order
  end

  def canceled
    @order.canceled!
    flash[:notice] = 'Pedido cancelado'
    redirect_to @order
  end

  def index
    @orders = Order.all
  end

  def show
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

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    if @order.update(order_params)
      flash[:notice] = 'Pedido atualizado com sucesso'
      redirect_to @order
    else
      flash.now[:notice] = 'Não foi possível atualizar o pedido'
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      render 'edit'
    end
  end

  private

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date, :status)
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def check_user
    return if current_user == @order.user

    flash[:notice] = 'Você não tem permissão para editar este pedido'
    redirect_to root_path
  end
end
