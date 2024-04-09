class WarehousesController < ApplicationController
  
  def show
    find_warehouse
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

  def edit
    find_warehouse
  end

  def update
    find_warehouse
    if @warehouse.update(warehouse_params)
      flash[:notice] = 'Galpão atualizado com sucesso'
      redirect_to root_path
    else
      flash.now[:notice] = 'Galpão não atualizado'
      render 'edit'
    end
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :area, :address, :cep, :description)
  end

  def find_warehouse
    @warehouse = Warehouse.find(params[:id])
  end
end
