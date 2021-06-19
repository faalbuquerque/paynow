class PixMethodsController < ApplicationController
  before_action :authenticate_admin!
  before_action :paynow_company, only: %i[ index show new create edit update ]
  before_action :set_pix_method, only: %i[ show edit update ]

  def index
    @pix_methods = @paynow.pix_methods.all
  end

  def new
    @pix_method =  @paynow.pix_methods.new
  end

  def create
    @pix_method = @paynow.pix_methods.new(pix_method_params)
    msg = t('.success')
    return redirect_to @pix_method, notice: msg if @pix_method.save

    render :new
  end

  def show
  end

  def edit
  end

  def update
    msg = t('.success')
    return redirect_to @pix_method, notice: msg if @pix_method.update(pix_method_params)

    render :new
  end

  private

  def pix_method_params
    params.require(:pix_method).permit(:name, :icon, :tax_charge, :tax_max,
                                       :code_bank,:code_pix, :available )
  end

  def paynow_company
    @paynow = Company.find_by(corporate_name: 'Paynow')
  end

  def set_pix_method
    @pix_method = @paynow.pix_methods.find_by(id: params[:id])
  end
end
