class Api::V1::CardBillingsController < Api::V1::CustomApiController

  def create
    return render json: { message: "Dados inválidos" } unless is_data_valid?(params[:card_billing], 'card')

    @card_billing = CardBilling.new(card_billing_params)

    calculate_billing_values
    @card_billing.create_token

    if @card_billing.save
      return render json: { message: "Cobrança gerada com sucesso!", token: @card_billing.token }
    end
    render json: { message: "Oops, algo saiu errado, tente novamente!" }
  end

  private

  def card_billing_params
    params.require(:card_billing).permit(:company_token, :product_token,
                                         :client_token, :client_name,
                                         :client_surname, :client_cpf,
                                         :payment_method, :client_card_number,
                                         :client_card_name, :client_card_code)
  end

  def calculate_billing_values
    product = Product.find_by(token: params[:card_billing][:product_token])
    product_price = product.product_price.to_d

    company = Company.find_by(token: params[:card_billing][:company_token])
    card_method = company.card_methods.find_by(name: params[:card_billing][:payment_method])

    tax_charge = card_method.tax_charge.to_d
    limit_tax = card_method.tax_max.to_d

    payment_discount = (product.discounts.exists?(payment_type: card_method.name))?
                          product.discounts.find_by(payment_type: card_method.name).amount.to_d :
                            0;

    @card_billing.payment_tax_billing = tax_charge
    @card_billing.payment_tax_max = limit_tax
    @card_billing.product_discont = payment_discount

    @card_billing.product_original_price = product_price

    tax_in_money = product_price * (tax_charge/100) if (tax_charge/100) < limit_tax
    tax_in_money = limit_tax if product_price * (tax_charge/100) >= limit_tax

    calculated_discount = product_price * (payment_discount/100)

    @card_billing.product_final_price = product_price + tax_in_money - calculated_discount
  end
end
