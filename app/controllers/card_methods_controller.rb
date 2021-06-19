class CardMethodsController < ApplicationController
  before_action :authenticate_admin!
  before_action :paynow_company, only: %i[ index show new create edit update ]
  before_action :set_card_method, only: %i[ show edit update ]

  def index
    @card_methods = @paynow.card_methods.all
  end

  def new
    @card_method =  @paynow.card_methods.new
  end

  def create
    @card_method = @paynow.card_methods.new(card_method_params)
    msg = t('.success')
    return redirect_to @card_method, notice: msg if @card_method.save

    render :new
  end

  def show
  end

  def edit
  end

  def update
    msg = t('.success')
    return redirect_to @card_method, notice: msg if @card_method.update(card_method_params)

    render :new
  end

  private

  def card_method_params
    params.require(:card_method).permit(:name, :icon, :tax_charge, :tax_max, 
                                        :code, :available)
  end

  def paynow_company
    @paynow = Company.find_by(corporate_name: 'Paynow')
  end

  def set_card_method
    @card_method = @paynow.card_methods.find_by(id: params[:id])
  end
end
