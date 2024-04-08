class WarehousesController < ApplicationController
  
  def show
    find_warehouse
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :area, :address, :cep, :description)
  end

  def find_warehouse
    @warehouse = Warehouse.find(params[:id])
  end
end
