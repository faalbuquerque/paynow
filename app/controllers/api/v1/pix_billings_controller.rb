class Api::V1::PixBillingsController < Api::V1::CustomApiController

  def create
    return render json: { message: "Dados inválidos" } unless is_data_valid?(params[:pix_billing], 'pix')

    @pix_billing = PixBilling.new(pix_billing_params)

    calculate_billing_values
    @pix_billing.create_token

    if @pix_billing.save
      return render json: { message: "Cobrança gerada com sucesso!", token: @pix_billing.token }
    end
    render json: { message: "Oops, algo saiu errado, tente novamente!" }
  end

  private

  def pix_billing_params
    params.require(:pix_billing).permit(:company_token, :product_token, :client_token, :client_name, :client_surname, :client_cpf, :payment_method)
  end

  def calculate_billing_values
    product = Product.find_by(token: params[:pix_billing][:product_token])
    product_price = product.product_price.to_d

    company = Company.find_by(token: params[:pix_billing][:company_token])
    pix_method = company.pix_methods.find_by(name: params[:pix_billing][:payment_method])

    tax_charge = pix_method.tax_charge.to_d
    limit_tax = pix_method.tax_max.to_d

    payment_discount = (product.discounts.exists?(payment_type: pix_method.name))?
                          product.discounts.find_by(payment_type: pix_method.name).amount.to_d : 
                            0;
    # payment_discount = product.discounts.find_by(payment_type: pix_method.name).amount.to_d

    @pix_billing.payment_tax_billing = tax_charge
    @pix_billing.payment_tax_max = limit_tax
    @pix_billing.product_discont = payment_discount

    @pix_billing.product_original_price = product_price

    tax_in_money = product_price * (tax_charge/100) if (tax_charge/100) < limit_tax
    tax_in_money = limit_tax if product_price * (tax_charge/100) >= limit_tax

    calculated_discount = product_price * (payment_discount/100)

    @pix_billing.product_final_price = product_price + tax_in_money - calculated_discount
  end
end
