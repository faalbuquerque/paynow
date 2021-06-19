require 'rails_helper'

feature 'Admin manages Boleto payment method' do
  scenario 'successfully' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                   billing_email: 'paynow@company.com')

    login_as admin, scope: :admin

    visit root_path
    click_on 'Dashboard'
    click_on 'Boleto'
    click_on 'Adicionar'
    fill_in 'Nome', with: 'Boleto'
    fill_in 'Taxa de cobrança', with: '4,5%'
    fill_in 'Taxa máxima', with: '6%'
    fill_in 'Código do banco', with: '127'
    fill_in 'Número de agencia', with: '333'
    fill_in 'Número da conta', with: '127.4.3.222'
    click_on 'Criar Boleto'

    expect(page).to have_text('Boleto')
    expect(page).to have_text('4,5%')
    expect(page).to have_text('6%')
    expect(page).to have_text('127')
    expect(page).to have_text('333')
    expect(page).to have_text('127.4.3.222')
  end

  scenario 'edit Boleto' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                             billing_email: 'paynow@company.com')

    paynow.billet_methods.create!(name: 'Boleto', icon:'imagem', tax_charge: '3%',
                                  tax_max: '4%',code_bank:'333', agency_bank: '333',
                                  account_number:'127.4.3.222')

    login_as admin, scope: :admin

    visit admins_manages_path
    click_on 'Boleto'
    click_on 'Editar'

    fill_in 'Nome', with: 'Boleto'
    fill_in 'Taxa de cobrança', with: '4,4%'
    fill_in 'Taxa máxima', with: '11%'
    fill_in 'Código do banco', with: '128'
    fill_in 'Número de agencia', with: '123'
    fill_in 'Número da conta', with: '127.4.3.222'
    click_on 'Atualizar Boleto'

    expect(page).to have_text('Boleto')
    expect(page).to have_text('4,4%')
    expect(page).to have_text('11%')
    expect(page).to have_text('128')
    expect(page).to have_text('123')
    expect(page).to have_text('127.4.3.222')
  end

  scenario 'edit fiels cannot be blank' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.billet_methods.create!(name: 'Boleto', icon:'imagem',
                                  tax_charge: '3%', tax_max: '4%',code_bank:'333', 
                                  agency_bank: '333', account_number:'127.4.3.222')

    login_as admin, scope: :admin

    visit admins_manages_path
    click_on 'Boleto'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Taxa de cobrança', with: ''
    fill_in 'Taxa máxima', with: ''
    fill_in 'Código do banco', with: ''
    fill_in 'Número de agencia', with: ''
    fill_in 'Número da conta', with: ''
    click_on 'Atualizar Boleto'

    expect(page).to have_text('Nome não pode ficar em branco')
    expect(page).to have_text('Taxa de cobrança não pode ficar em branco')
    expect(page).to have_text('Taxa máxima não pode ficar em branco')
    expect(page).to have_text('Código do banco não pode ficar em branco')
    expect(page).to have_text('Número de agencia não pode ficar em branco')
    expect(page).to have_text('Número da conta não pode ficar em branco')
  end

  scenario 'new fiels cannot be blank' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                   billing_email: 'paynow@company.com')

    login_as admin, scope: :admin

    visit root_path
    click_on 'Dashboard'
    click_on 'Boleto'
    click_on 'Adicionar'
    fill_in 'Nome', with: ''
    fill_in 'Taxa de cobrança', with: ''
    fill_in 'Taxa máxima', with: ''
    fill_in 'Código do banco', with: ''
    fill_in 'Número de agencia', with: ''
    fill_in 'Número da conta', with: ''
    click_on 'Criar Boleto'

    expect(page).to have_text('Nome não pode ficar em branco')
    expect(page).to have_text('Taxa de cobrança não pode ficar em branco')
    expect(page).to have_text('Taxa máxima não pode ficar em branco')
    expect(page).to have_text('Código do banco não pode ficar em branco')
    expect(page).to have_text('Número de agencia não pode ficar em branco')
    expect(page).to have_text('Número da conta não pode ficar em branco')
  end

  scenario 'only administrator can add billet method' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                   billing_email: 'paynow@company.com')

    login_as admin, scope: :admin

    visit root_path
    click_on 'Dashboard'
    click_on 'Boleto'
    click_on 'Adicionar'
    fill_in 'Nome', with: 'Boleto'
    fill_in 'Taxa de cobrança', with: '4,5%'
    fill_in 'Taxa máxima', with: '6%'
    fill_in 'Código do banco', with: '127'
    fill_in 'Número de agencia', with: '333'
    fill_in 'Número da conta', with: '127.4.3.222'

    logout

    click_on 'Criar Boleto'

    expect(page).to have_text('Para continuar, efetue login ou registre-se')
    expect(page).to_not have_text('Boleto')
    expect(page).to_not have_text('4,5%')
    expect(page).to_not have_text('6%')
    expect(page).to_not have_text('127')
    expect(page).to_not have_text('333')
    expect(page).to_not have_text('127.4.3.222')
  end

  scenario 'only administrator can edit billet method' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                             billing_email: 'paynow@company.com')

    paynow.billet_methods.create!(name: 'Boleto', icon:'imagem', tax_charge: '3%',
                                  tax_max: '4%',code_bank:'333', agency_bank: '333',
                                  account_number:'127.4.3.222')

    login_as admin, scope: :admin

    visit admins_manages_path
    click_on 'Boleto'
    click_on 'Editar'

    fill_in 'Nome', with: 'Boleto'
    fill_in 'Taxa de cobrança', with: '4,4%'
    fill_in 'Taxa máxima', with: '11%'
    fill_in 'Código do banco', with: '128'
    fill_in 'Número de agencia', with: '123'
    fill_in 'Número da conta', with: '127.4.3.222'

    logout

    click_on 'Atualizar Boleto'

    expect(page).to have_text('Para continuar, efetue login ou registre-se')
    expect(page).to_not have_text('Boleto')
    expect(page).to_not have_text('4,4%')
    expect(page).to_not have_text('11%')
    expect(page).to_not have_text('128')
    expect(page).to_not have_text('123')
    expect(page).to_not have_text('127.4.3.222')
  end
end
