class Api::V1::CustomApiController < ActionController::API
  def is_data_valid?(payment_method, type)
    company = Company.is_existent?(payment_method[:company_token])
    product = Product.is_existent?(payment_method[:product_token])
    client = Client.is_existent?(payment_method[:client_token])

    payment = has_pix_method(payment_method[:company_token],
                             payment_method[:payment_method]) if type == 'pix'

    payment = has_card_method(payment_method[:company_token],
                             payment_method[:payment_method]) if type == 'card'

    payment = has_billet_method(payment_method[:company_token],
                                payment_method[:payment_method]) if type == 'billet'

    company && product && client && payment
  end

  def has_pix_method(company_token, payment_method_name)
    company = Company.find_by(token: company_token)
    return !!company.pix_methods.find_by(name: payment_method_name) if company
    false
  end

  def has_billet_method(company_token, payment_method_name)
    company = Company.find_by(token: company_token)
    return !!company.billet_methods.find_by(name: payment_method_name) if company
    false
  end

  def has_card_method(company_token, payment_method_name)
    company = Company.find_by(token: company_token)
    return !!company.card_methods.find_by(name: payment_method_name) if company
    false
  end
end
