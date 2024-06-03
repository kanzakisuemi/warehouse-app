class WarehousesController < ApplicationController
  before_action :set_warehouse, only: %i[show edit update destroy]

  def show
    @stock = @warehouse.stock_products.where.missing(:stock_product_destination).group(:product_model).count
    @product_models = []

    @warehouse.stock_products.group(:product_model_id).pluck(:product_model_id).each do |product_model_id|
      product_model = ProductModel.find(product_model_id)
      @product_models << product_model
    end
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save
      flash[:notice] = 'Galpão cadastrado com sucesso'
      redirect_to root_path
    else
      flash.now[:notice] = 'Galpão não cadastrado'
      render 'new'
    end
  end

  def edit; end

  def update
    if @warehouse.update(warehouse_params)
      flash[:notice] = 'Galpão atualizado com sucesso'
      redirect_to root_path
    else
      flash.now[:notice] = 'Galpão não atualizado'
      render 'edit'
    end
  end

  def destroy
    @warehouse.destroy
    flash[:notice] = 'Galpão excluído com sucesso'
    redirect_to root_path
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :area, :address, :cep, :description)
  end

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end
end
