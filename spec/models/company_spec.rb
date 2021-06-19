require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should have_many(:workers) }
  it { should have_db_column(:domain) }
  it { should have_db_column(:token) }
  it { should have_many(:card_methods) }
  it { should have_many(:billet_methods) }
  it { should have_many(:pix_methods) }

  context 'should check if' do
    it 'typed correct password' do
      company = Company.create!(cnpj: '24.098.348/0001-21',
                                corporate_name:'Empresa',
                                billing_email: 'empresa@test.com')

      company.create_token

      expect(company.token.blank?).to be_falsy
      expect(company.token.size).to eq(20)
    end

    it 'generated different tokens' do
      first_company = Company.create!(cnpj: '24.098.348/0001-21',
                                      corporate_name:'First company',
                                      billing_email: 'first_company@test.com')

      some_company = Company.create!(cnpj: '10.416.778/0001-30',
                                     corporate_name:'Some company',
                                     billing_email: 'somecompany@test.com')

      other_company = Company.create!(cnpj: '74.292.587/0001-96',
                                      corporate_name:'Other company',
                                      billing_email: 'other_company@test.com')

      first_company.create_token
      some_company.create_token
      other_company.create_token

      expect(first_company.token).to_not eq some_company.token
      expect(first_company.token).to_not eq other_company.token
      expect(some_company.token).to_not eq other_company.token
    end

    it 'different tokens when same name and same second' do
      some_company = Company.create!(cnpj: '10.416.778/0001-30',
                                     corporate_name:'Some name',
                                     billing_email: 'somecompany@test.com')

      other_company = Company.create!(cnpj: '74.292.587/0001-96',
                                      corporate_name:'Some name',
                                      billing_email: 'other_company@test.com')

      some_company.create_token
      other_company.create_token

      expect(some_company.token).to_not eq other_company.token
    end
  end
end
