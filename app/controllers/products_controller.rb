class ProductsController < ApplicationController
  before_action :authenticate_worker!

  def index
    @products = current_worker.company.products.all
  end

  def new
    @product = current_worker.company.products.new()
  end

  def create
    @product = current_worker.company.products.new(product_params)
    @product.create_token
    msg = t('.success')
    return redirect_to @product, notice: msg if @product.save

    render :new
  end

  def show
    @product = current_worker.company.products.find(params[:id])
  end

  def edit
    @product = current_worker.company.products.find(params[:id])
  end

  def update
    @product = current_worker.company.products.find(params[:id])
    msg = t('.success')
    return redirect_to @product, notice: msg if @product.update(product_params)

    render :edit
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :product_price, :token)
  end

end