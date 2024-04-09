class WarehousesController < ApplicationController
  before_action :find_warehouse, only: %i[show edit update destroy]

  def show; end

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

  def find_warehouse
    @warehouse = Warehouse.find(params[:id])
  end
end
