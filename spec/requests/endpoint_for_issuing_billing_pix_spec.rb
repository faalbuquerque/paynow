require 'rails_helper'

describe 'End point for issuing billing - Pix' do
  context 'POST successfully' do
    it 'api/v1/pix_billings' do
      company = Company.new(cnpj: '24.098.348/0001-21',
                            corporate_name:'Company',
                            billing_email: 'company@company.com')
      company.create_token
      company.save!

      post '/api/v1/clients', params: { client: { name: 'Ana', surname: 'Sá',
                                        cpf: '129.640.270-30',
                                        company_token: company.token } }

      pix_method = company.pix_methods.create!(name: 'Pix MP', tax_charge: '2',
                                              tax_max: '10', code_bank:'777',
                                              code_pix: '555', available: true)

      product_ruby = company.products.new(product_name: 'Curso de ruby',
                                          product_price: '150')
      product_ruby.create_token
      product_ruby.save

      product_ruby.discounts.create!(amount:'3', payment_type:'Pix MP')

      post '/api/v1/pix_billings', params: { pix_billing: {
                                   company_token: company.token,
                                   product_token: product_ruby.token,
                                   client_token: Client.first.token,
                                   client_name: 'maria',
                                   client_surname: 'silva',
                                   client_cpf: '173.097.520-82',
                                   payment_method: pix_method.name
                                 }
                               }

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include("Cobrança gerada com sucesso!")
      expect(parsed_body['token']).to eq(PixBilling.first.token)
    end
  end

  context 'POST empty parameters' do
    it 'api/v1/pix_billings' do

      post '/api/v1/clients', params: {}, headers: { 'Content-Type': 'application/json' }

      expect(response.body).to include("parâmetros inválidos")
    end
  end

  context 'POST invalid parameters' do
    it 'api/v1/pix_billings ' do
      company = Company.new(cnpj: '24.098.348/0001-21',
      corporate_name:'Company',
      billing_email: 'company@company.com')
      company.create_token
      company.save!

      post '/api/v1/clients', params: { client: { name: 'Ana', surname: 'Sá',
                          cpf: '129.640.270-30',
                          company_token: company.token } }

      pix_method = company.pix_methods.create!(name: 'Pix MP', tax_charge: '2',
                                tax_max: '10', code_bank:'777',
                                code_pix: '555', available: true)

      product_ruby = company.products.new(product_name: 'Curso de ruby',
                            product_price: '150')
      product_ruby.create_token
      product_ruby.save

      post '/api/v1/pix_billings', params: { pix_billing: {
                    company_token: '',
                    product_token: '',
                    client_token: '',
                    client_name: 'maria',
                    client_surname: 'silva',
                    client_cpf: '173.097.520-82',
                    payment_method: ''
                  }
                }

      expect(response.body).to include("Dados inválidos")
    end
  end
end
