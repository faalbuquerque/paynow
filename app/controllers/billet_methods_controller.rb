class BilletMethodsController < ApplicationController
  before_action :authenticate_admin!
  before_action :paynow_company, only: %i[ index show new create edit update ]
  before_action :set_billet_method, only: %i[ show edit update ]

  def index
    @billet_methods = @paynow.billet_methods.all
  end

  def new
    @billet_method =  @paynow.billet_methods.new
  end

  def create
    @billet_method = @paynow.billet_methods.new(billet_method_params)
    msg = t('.success')
    return redirect_to @billet_method, notice: msg if @billet_method.save

    render :new
  end

  def show
  end

  def edit
  end

  def update
    msg = t('.success')
    return redirect_to @billet_method, notice: msg if @billet_method.update(billet_method_params)

    render :new
  end

  private

  def billet_method_params
    params.require(:billet_method).permit(:name, :icon, :tax_charge, :tax_max,
                                          :code_bank, :agency_bank,
                                          :account_number, :available)
  end

  def paynow_company
    @paynow = Company.find_by(corporate_name: 'Paynow')
  end

  def set_billet_method
    @billet_method = @paynow.billet_methods.find_by(id: params[:id])
  end
end
