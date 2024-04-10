class ProductModelsController < ApplicationController
  before_action :set_product_model, only: %i[show]
  def index
    @product_models = ProductModel.all
  end

  def show; end

  def new
    @suppliers = Supplier.all
    @product_model = ProductModel.new
  end

  def create
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save
      flash[:notice] = 'Produto cadastrado com sucesso'
      redirect_to @product_model
    else
      @suppliers = Supplier.all
      flash.now[:notice] = 'Não foi possível cadastrar o produto'
      render :new
    end
  end

  private

  def product_model_params
    params.require(:product_model).permit(:name, :weight, :width, :height, :length, :depth, :sku, :supplier_id)
  end

  def set_product_model
    @product_model = ProductModel.find(params[:id])
  end
end
