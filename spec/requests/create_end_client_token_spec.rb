require 'rails_helper'

describe 'Create end client token' do
  context 'POST ' do
    it '/api/v1/clients' do
      company = Company.new(cnpj: '24.098.348/0001-21',
                            corporate_name:'Company',
                            billing_email: 'company@company.com')
      company.create_token
      company.save!

      post '/api/v1/clients', params: { client: { name: 'Ana', surname: 'Sá',
                                                  cpf: '129.640.270-30',
                                                  company_token: company.token }
                                      }

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['name']).to eq('Ana')
      expect(parsed_body['surname']).to eq('Sá')
      expect(parsed_body['cpf']).to eq('129.640.270-30')
    end

    it 'token size in client' do
      company = Company.new(cnpj: '24.098.348/0001-21',
                            corporate_name:'Company',
                            billing_email: 'company@company.com')
      company.create_token
      company.save!

      post '/api/v1/clients', params: { client: { name: 'Ana', surname: 'Sá',
                                                  cpf: '129.640.270-30',
                                                  company_token: company.token }
                                      }

      expect(Client.first.token.size).to eq(20)
    end

    it 'token linked to cpf' do
      company = Company.new(cnpj: '24.098.348/0001-21',
                            corporate_name:'Company',
                            billing_email: 'company@company.com')
      company.create_token
      company.save!

      post '/api/v1/clients', params: { client: { name: 'Ana', surname: 'Sá',
                                                  cpf: '129.640.270-30',
                                                  company_token: company.token }
                                      }

      post '/api/v1/clients', params: { client: { name: 'Paula', surname: 'Souza',
                                                  cpf: '129.640.270-30',
                                                  company_token: company.token }
                                      }

      parsed_body = JSON.parse(response.body)
      expect(parsed_body['name']).to eq('Ana')
      expect(parsed_body['surname']).to eq('Sá')
      expect(parsed_body['cpf']).to eq('129.640.270-30')
      expect(parsed_body['name']).to_not eq('Paula')
      expect(parsed_body['surname']).to_not eq('Souza')
    end
  end
end
