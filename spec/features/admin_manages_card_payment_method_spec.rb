require 'rails_helper'

feature 'Admin manages card payment method' do
  scenario 'successfully' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                             billing_email: 'paynow@company.com')

    login_as admin, scope: :admin

    visit root_path
    click_on 'Dashboard'
    click_on 'Cartão de Crédito'
    click_on 'Adicionar'
    fill_in 'Nome', with: 'Cartão de crédito'
    fill_in 'Taxa de cobrança', with: '4,5%'
    fill_in 'Taxa máxima', with: '6%'
    fill_in 'Código do banco', with: '127'
    click_on 'Criar Cartão'

    expect(page).to have_text('Cartão de crédito')
    expect(page).to have_text('4,5%')
    expect(page).to have_text('6%')
    expect(page).to have_text('127')
  end

  scenario 'edit card' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.card_methods.create!(name: 'cartão de crédito', icon:'imagem',
                                tax_charge: '3%', tax_max: '4%', code:'333')

    login_as admin, scope: :admin

    visit admins_manages_path
    click_on 'Cartão de Crédito'
    click_on 'Editar'

    fill_in 'Nome', with: 'cartão 2'
    fill_in 'Taxa de cobrança', with: '4,5%'
    fill_in 'Taxa máxima', with: '6%'
    fill_in 'Código do banco', with: '127'
    click_on 'Atualizar Cartão'

    expect(page).to have_text('cartão 2')
    expect(page).to have_text('4,5%')
    expect(page).to have_text('6%')
    expect(page).to have_text('127')
  end

  scenario 'edit fiels cannot be blank' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.card_methods.create!(name: 'cartão de crédito', icon:'imagem',
                                tax_charge: '3%', tax_max: '4%', code:'333')

    login_as admin, scope: :admin

    visit admins_manages_path
    click_on 'Cartão de Crédito'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Taxa de cobrança', with: ''
    fill_in 'Taxa máxima', with: ''
    fill_in 'Código do banco', with: ''
    click_on 'Atualizar Cartão'

    expect(page).to have_text('Nome não pode ficar em branco')
    expect(page).to have_text('Taxa de cobrança não pode ficar em branco')
    expect(page).to have_text('Taxa máxima não pode ficar em branco')
    expect(page).to have_text('Código do banco não pode ficar em branco')
  end

  scenario 'new fiels cannot be blank' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                   billing_email: 'paynow@company.com')

    login_as admin, scope: :admin

    visit root_path
    click_on 'Dashboard'
    click_on 'Cartão de Crédito'
    click_on 'Adicionar'
    fill_in 'Nome', with: ''
    fill_in 'Taxa de cobrança', with: ''
    fill_in 'Taxa máxima', with: ''
    fill_in 'Código do banco', with: ''
    click_on 'Criar Cartão'

    expect(page).to have_text('Nome não pode ficar em branco')
    expect(page).to have_text('Taxa de cobrança não pode ficar em branco')
    expect(page).to have_text('Taxa máxima não pode ficar em branco')
    expect(page).to have_text('Código do banco não pode ficar em branco')
  end

  scenario 'only administrator can add card method' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                             billing_email: 'paynow@company.com')

    login_as admin, scope: :admin

    visit root_path
    click_on 'Dashboard'
    click_on 'Cartão de Crédito'
    click_on 'Adicionar'
    fill_in 'Nome', with: 'Cartão de crédito'
    fill_in 'Taxa de cobrança', with: '4,5%'
    fill_in 'Taxa máxima', with: '6%'
    fill_in 'Código do banco', with: '127'

    logout

    click_on 'Criar Cartão'

    expect(page).to have_text('Para continuar, efetue login ou registre-se')
    expect(page).to_not have_text('Cartão de crédito')
    expect(page).to_not have_text('4,5%')
    expect(page).to_not have_text('6%')
    expect(page).to_not have_text('127')
  end

  scenario 'only administrator can edit card method' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.card_methods.create!(name: 'cartão de crédito', icon:'imagem',
                                tax_charge: '3%', tax_max: '4%', code:'333')

    login_as admin, scope: :admin

    visit admins_manages_path
    click_on 'Cartão de Crédito'
    click_on 'Editar'

    fill_in 'Nome', with: 'cartão 2'
    fill_in 'Taxa de cobrança', with: '4,5%'
    fill_in 'Taxa máxima', with: '6%'
    fill_in 'Código do banco', with: '127'

    logout

    click_on 'Atualizar Cartão'

    expect(page).to have_text('Para continuar, efetue login ou registre-se')
    expect(page).to_not have_text('cartão 2')
    expect(page).to_not have_text('4,5%')
    expect(page).to_not have_text('6%')
    expect(page).to_not have_text('127')
  end
end
