require 'rails_helper'

feature 'Admin toggles payment methods' do
  context 'pix' do
    scenario 'successfully available' do
      admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                            password:'wonyap')

      paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                              billing_email: 'paynow@company.com')

      pix = paynow.pix_methods.create!(name: 'Pix', icon:'imagem', tax_charge: '3%',
                                       tax_max: '4%', code_bank:'333',
                                       code_pix:  '7f44bab8b08a3fb07555')

      login_as admin, scope: :admin
      visit edit_pix_method_path(pix)

      find('input[type="checkbox"]').set(true)
      click_on 'Atualizar Pix'

      expect(page).to have_text('Disponivel')
    end

    scenario 'successfully unavailable' do
      admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                            password:'wonyap')

      paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                              billing_email: 'paynow@company.com')

      pix = paynow.pix_methods.create!(name: 'Pix', icon:'imagem', tax_charge: '3%',
                                       tax_max: '4%', code_bank:'333',
                                       code_pix: '7f44bab8b08a3fb07555',
                                       available: true)

      login_as admin, scope: :admin
      visit edit_pix_method_path(pix)

      find('input[type="checkbox"]').set(false)
      click_on 'Atualizar Pix'

      expect(page).to have_text('Indisponivel')
    end
  end

  context 'billet' do
    scenario 'successfully available' do
      admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                            password:'wonyap')

      paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                              billing_email: 'paynow@company.com')

      billet = paynow.billet_methods.create!(name: 'Boleto', icon:'imagem',
                                             tax_charge: '3%', tax_max: '4%',
                                             code_bank:'333', agency_bank: '333',
                                             account_number:'127.4.3.222')

      login_as admin, scope: :admin
      visit edit_billet_method_path(billet)

      find('input[type="checkbox"]').set(true) 
      click_on 'Atualizar Boleto'

      expect(page).to have_text('Disponivel')
    end

    scenario 'successfully unavailable' do
      admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                            password:'wonyap')

      paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                              billing_email: 'paynow@company.com')

      billet = paynow.billet_methods.create!(name: 'Boleto', icon:'imagem',
                                             tax_charge: '3%', tax_max: '4%',
                                             code_bank:'333', agency_bank: '333',
                                             account_number:'127.4.3.222',
                                             available: true)

      login_as admin, scope: :admin
      visit edit_billet_method_path(billet)

      find('input[type="checkbox"]').set(false)
      click_on 'Atualizar Boleto'

      expect(page).to have_text('Indisponivel')
    end
  end

  context 'card' do
    scenario 'successfully available' do
      admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                            password:'wonyap')

      paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                              billing_email: 'paynow@company.com')

      card = paynow.card_methods.create!(name: 'cartão de crédito', icon:'imagem',
                                        tax_charge: '3%', tax_max: '4%',
                                        code:'333', available: true)

      login_as admin, scope: :admin
      visit edit_card_method_path(card)

      find('input[type="checkbox"]').set(true)
      click_on 'Atualizar Cartão'

      expect(page).to have_text('Disponivel')
    end

    scenario 'successfully unavailable' do
      admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                            password:'wonyap')

      paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                              billing_email: 'paynow@company.com')

      card = paynow.card_methods.create!(name: 'cartão de crédito', icon:'imagem',
                                         tax_charge: '3%', tax_max: '4%',
                                         code:'333', available: true)
      login_as admin, scope: :admin
      visit edit_card_method_path(card)

      find('input[type="checkbox"]').set(false)
      click_on 'Atualizar Cartão'

      expect(page).to have_text('Indisponivel')
    end
  end
end
