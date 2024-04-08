class HomeController < ApplicationController
  def index
    @warehouses = Warehouse.all
  end

  def show
    find_warehouse
  end

  def new
  end

  def create
    warehouse = Warehouse.new(warehouse_params)
    warehouse.save
    redirect_to root_path
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :area)
  end

  def find_warehouse
    @warehouse = Warehouse.find(params[:id])
  end
end
