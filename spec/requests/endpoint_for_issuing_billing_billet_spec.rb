require 'rails_helper'

describe 'End point for issuing billing - Billet' do
  context 'POST successfully' do
    it 'api/v1/billet_billings' do
      company = Company.new(cnpj: '24.098.348/0001-21', corporate_name:'Company',
                            billing_email: 'company@company.com')
      company.create_token
      company.save!

      post '/api/v1/clients', params: { client: { name: 'Ana', surname: 'Sá',
                                                  cpf: '129.640.270-30',
                                                  company_token: company.token }
                                                }

      billet_method = company.billet_methods.create!(name: 'Boleto Itau',
                                                     tax_charge: '2',
                                                     tax_max: '3',
                                                     code_bank:'222',
                                                     agency_bank: '999',
                                                     account_number:'127.4.3.222',
                                                     available: true)

      product_ruby = company.products.new(product_name: 'Curso de ruby',
                                          product_price: '150')
      product_ruby.create_token
      product_ruby.save

      post '/api/v1/billet_billings', params: { billet_billing: {
                                                  company_token: company.token,
                                                  product_token: product_ruby.token,
                                                  client_token: Client.first.token,
                                                  payment_method: billet_method.name,
                                                  client_name: "maria",
                                                  client_surname: "silva",
                                                  client_cpf: "173.097.520-82",
                                                  zip_code: "13214701",
                                                  state: "SP",
                                                  city: "Sao Paulo",
                                                  street: "Rua Uva Isabel",
                                                  house_number: "123",
                                                  complement: "casa" }
                                              }

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include("Cobrança gerada com sucesso!")
      expect(parsed_body['token']).to eq(BilletBilling.first.token)
    end
  end

  context 'POST empty parameters' do
    it 'api/v1/billet_billings' do

      post '/api/v1/billet_billings', params: {}, headers: { 'Content-Type':
                                                             'application/json'
                                                           }

      expect(response.body).to include("Dados inválidos")
    end
  end

  context 'POST invalid parameters' do
    it 'api/v1/billet_billings' do
      company = Company.new(cnpj: '24.098.348/0001-21',
      corporate_name:'Company',
      billing_email: 'company@company.com')
      company.create_token
      company.save!

      post '/api/v1/clients', params: { client: { name: 'Ana', surname: 'Sá',
                                                  cpf: '129.640.270-30',
                                                  company_token: company.token }
                                                }

      billet_method = company.billet_methods.create!(name: 'Boleto Itau',
                                                     tax_charge: '2',
                                                     tax_max: '3', code_bank:'222',
                                                     agency_bank: '1155',
                                                     account_number:'127.4.3.222',
                                                     available: true)

      product_ruby = company.products.new(product_name: 'Curso de ruby',
                                          product_price: '150')
      product_ruby.create_token
      product_ruby.save

      post '/api/v1/billet_billings', params:{ billet_billing: {
                                                  company_token: "1h2h3h3",
                                                  product_token: "",
                                                  client_token: Client.first,
                                                  payment_method: "jhsgajgjgdj",
                                                  client_name: "maria",
                                                  client_surname: "silva",
                                                  client_cpf: "173.097.520-82",
                                                  zip_code: "",
                                                  state: "SP",
                                                  city: "",
                                                  street: "Rua Uva Isabel",
                                                  house_number: "123",
                                                  complement: "" }
                                              }

      expect(response.body).to include("Dados inválidos")
    end
  end
end
