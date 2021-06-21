class DiscountsController < ApplicationController
  before_action :authenticate_worker!

  def new
    @product = current_worker.company.products.find(params[:id])
    @discount = @product.discounts.new
    @payment_methods = current_worker.company.payment_methods
                                     .select{|item| item.available == true }
                                     .pluck(:name)
  end

  def create
    @payment_methods = current_worker.company.payment_methods
                                     .select{|item| item.available == true }
                                     .pluck(:name)

    @product = current_worker.company.products.find(params[:discount][:id])
    @discount = @product.discounts.new(discount_params)
    return redirect_to @product if @discount.save

    render :new
  end

  private

  def discount_params
    params.require(:discount).permit(:amount, :payment_type)
  end
end
