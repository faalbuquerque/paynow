require 'rails_helper'

describe 'End point for issuing billing - Card' do
  context 'POST successfully' do
    it 'api/v1/card_billings' do
      company = Company.new(cnpj: '24.098.348/0001-21',
                            corporate_name:'Company',
                            billing_email: 'company@company.com')
      company.create_token
      company.save!

      post '/api/v1/clients', params: { client: { name: 'Ana', surname: 'Sá',
                                                  cpf: '129.640.270-30',
                                                  company_token: company.token }
                                                }

      card_method = company.card_methods.create!(name: 'Cartão Mast',
                                                 tax_charge: '6', tax_max: '7',
                                                 code:'444', available: true)

      product_ruby = company.products.new(product_name: 'Curso de ruby',
                                          product_price: '150')
      product_ruby.create_token
      product_ruby.save

      post '/api/v1/card_billings', params: { card_billing: {
                                                company_token: company.token,
                                                product_token: product_ruby.token,
                                                client_token: Client.first.token,
                                                client_name: "maria",
                                                client_surname: "silva",
                                                client_cpf: "173.097.520-82",
                                                payment_method: card_method.name,
                                                client_card_number: "5237827889175873",
                                                client_card_name: "maria s",
                                                client_card_code: "969" }
                                            }

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include("Cobrança gerada com sucesso!")
      expect(parsed_body['token']).to eq(CardBilling.first.token)
    end
  end

  context 'POST empty parameters' do
    it 'api/v1/card_billings' do

      post '/api/v1/card_billings', params: {}, headers: { 'Content-Type':
                                                           'application/json' }

      expect(response.body).to include("Dados inválidos")
    end
  end

  context 'POST invalid parameters' do
    it 'api/v1/card_billings' do
      company = Company.new(cnpj: '24.098.348/0001-21', corporate_name:'Company',
                            billing_email: 'company@company.com')
      company.create_token
      company.save!

      post '/api/v1/clients', params: { client: { name: 'Ana', surname: 'Sá',
                                                  cpf: '129.640.270-30',
                                                  company_token: company.token }
                                                }


      card_method = company.card_methods.create!(name: 'Cartão Mast',
                                                 tax_charge: '6', tax_max: '7',
                                                 code:'444', available: true)

      product_ruby = company.products.new(product_name: 'Curso de ruby',
                                          product_price: '150')
      product_ruby.create_token
      product_ruby.save

      post '/api/v1/card_billings', params:{ card_billing: {
                                               company_token: "huhhhihhh",
                                               product_token: "kajkjsjakjsa",
                                               client_token: "kajsakjja",
                                               client_name: "",
                                               client_surname: "silva",
                                               client_cpf: "173.097.520-82",
                                               payment_method: "",
                                               client_card_number: "5237827889175873",
                                               client_card_name: "maria s",
                                               client_card_code: "969" }
                                            }

      expect(response.body).to include("Dados inválidos")
    end
  end
end
