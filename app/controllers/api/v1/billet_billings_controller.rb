class Api::V1::BilletBillingsController < Api::V1::CustomApiController

  def create
    return render json: { message: "Dados inválidos" } unless is_data_valid?(params[:billet_billing], 'billet')

    @billet_billing = BilletBilling.new(billet_billing_params)

    calculate_billing_values
    @billet_billing.create_token

    if @billet_billing.save
      return render json: { message: "Cobrança gerada com sucesso!", token: @billet_billing.token }
    end
    render json: { message: "Oops, algo saiu errado, tente novamente!" }
  end

  private

  def billet_billing_params
    params.require(:billet_billing).permit(:company_token, :product_token,
                                           :client_token, :client_name, :city,
                                           :client_surname, :client_cpf, :state,
                                           :zip_code, :street, :house_number,
                                           :payment_method, :complement)
  end

  def calculate_billing_values
    product = Product.find_by(token: params[:billet_billing][:product_token])
    product_price = product.product_price.to_d

    company = Company.find_by(token: params[:billet_billing][:company_token])
    billet_method = company.billet_methods.find_by(name: params[:billet_billing][:payment_method])

    tax_charge = billet_method.tax_charge.to_d
    limit_tax = billet_method.tax_max.to_d

    payment_discount = (product.discounts.exists?(payment_type: billet_method.name))?
                          product.discounts.find_by(payment_type: billet_method.name).amount.to_d :
                            0;

    @billet_billing.payment_tax_billing = tax_charge
    @billet_billing.payment_tax_max = limit_tax
    @billet_billing.product_discont = payment_discount

    @billet_billing.product_original_price = product_price

    tax_in_money = product_price * (tax_charge/100) if (tax_charge/100) < limit_tax
    tax_in_money = limit_tax if product_price * (tax_charge/100) >= limit_tax

    calculated_discount = product_price * (payment_discount/100)

    @billet_billing.product_final_price = product_price + tax_in_money - calculated_discount
  end
end
