class Workers::PaymentMethodsController < ApplicationController
  before_action :authenticate_worker!

  def index
    billets = current_worker.company.billet_methods
    cards = current_worker.company.card_methods
    pixes = current_worker.company.pix_methods

    @payment_methods = billets + cards + pixes
  end

  def new
    if params[:type] == 'billet'
      @payment_method = BilletMethod.new
      @payment_methods = BilletMethod.available_methods
    end
    if params[:type] == 'card'
      @payment_method = CardMethod.new
      @payment_methods = CardMethod.available_methods
    end
    if params[:type] == 'pix'
      @payment_method = PixMethod.new
      @payment_methods = PixMethod.available_methods
    end
  end

  def create
    if params[:billet_method]
      @payment_method = BilletMethod.clone_template(billet_method_params,
                                                    params[:BilletMethod][:id])

      @payment_methods = BilletMethod.available_methods
    end

    if params[:card_method]
      @payment_method = CardMethod.clone_template(card_method_params,
                                                  params[:CardMethod][:id])

      @payment_methods = CardMethod.available_methods
    end

    if params[:pix_method]
      @payment_method = PixMethod.clone_template(pix_method_params,
                                                 params[:PixMethod][:id])

      @payment_methods = PixMethod.available_methods
    end

    @payment_method.company_id = current_worker.company.id

    if @payment_method and @payment_method.available and @payment_method.save
      return redirect_to workers_payment_methods_path, notice: t('.added_payment')
    end

    inject_payment_type_into_params
    flash.now[:alert] = t('.error_payment_method')
    render :new
  end

  def edit
    company = current_worker.company

    if params[:type] == 'billet'
      @payment_method = company.billet_methods.find(params[:id])
      @payment_methods = BilletMethod.available_methods
    end
    if params[:type] == 'card'
      @payment_method = company.card_methods.find(params[:id])
      @payment_methods = CardMethod.available_methods
    end
    if params[:type] == 'pix'
      @payment_method = company.pix_methods.find(params[:id])
      @payment_methods = PixMethod.available_methods
    end
  end

  def update
    company = current_worker.company

    if params[:billet_method]
      @payment_method = company.billet_methods.find(params[:id])
      @payment_method.assign_attributes(billet_method_params)

      @payment_methods = BilletMethod.available_methods
    end

    if params[:card_method]
      @payment_method = company.card_methods.find(params[:id])
      @payment_method.assign_attributes(card_method_params)

      @payment_methods = CardMethod.available_methods
    end

    if params[:pix_method]
      @payment_method = company.pix_methods.find(params[:id])
      @payment_method.assign_attributes(pix_method_params)

      @payment_methods = PixMethod.available_methods
    end

    if  @payment_method and @payment_method.available and @payment_method.save
      return redirect_to workers_payment_methods_path, notice: t('.edited_payment')
    end

    inject_payment_type_into_params
    flash.now[:alert] = t('.error_payment_method')
    render :edit
  end

  private

  def billet_method_params
    params.require(:billet_method).permit(:code_bank, :agency_bank, :account_number)
  end

  def card_method_params
    params.require(:card_method).permit(:code)
  end

  def pix_method_params
    params.require(:pix_method).permit(:code_bank, :code_pix)
  end

  def inject_payment_type_into_params
    params[:type] = "#{@payment_method.class.to_s.delete_suffix('Method').downcase}"
  end
end
