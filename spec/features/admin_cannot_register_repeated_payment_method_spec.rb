require 'rails_helper'

feature 'Admin cannot register repeated payment method' do

    scenario 'New Billet' do
        admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                              password:'wonyap')

        company = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                                 billing_email: 'paynow@company.com')

        company.billet_methods.create!(name: 'Boleto', icon:'imagem', tax_charge: '3%',
                                       tax_max: '4%',code_bank:'333', agency_bank: '333',
                                       account_number:'127.4.3.222')

        login_as admin, scope: :admin

        visit new_billet_method_path(company)
        fill_in 'Nome', with: 'Boleto'
        click_on 'Criar Boleto'

        expect(page).to have_text('Metodo de pagamento Boleto já cadastrado!')
    end

    scenario 'New Card' do
        admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                              password:'wonyap')

        company = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                                 billing_email: 'paynow@company.com')

        company.card_methods.create!(name: 'Cartão de Crédito', icon:'imagem',
                                     tax_charge: '3%', tax_max: '4%', code:'333')

        login_as admin, scope: :admin
        visit new_card_method_path(company)

        fill_in 'Nome', with: 'Cartão de Crédito'
        click_on 'Criar Cartão'

        expect(page).to have_text('Metodo de pagamento Cartão já cadastrado!')
    end

    scenario 'New Pix' do
        admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                              password:'wonyap')

        company = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                                 billing_email: 'paynow@company.com')

        company.pix_methods.create!(name: 'Pix MP', icon:'imagem', tax_charge: '3%',
                                    tax_max: '4%', code_bank:'333',
                                    code_pix:  '7f44bab8b08a3fb07555')

        login_as admin, scope: :admin

        visit new_pix_method_path(company)
        fill_in 'Nome', with: 'Pix MP'
        click_on 'Criar Pix'

        expect(page).to have_text('Metodo de pagamento Pix já cadastrado!')
    end
end
