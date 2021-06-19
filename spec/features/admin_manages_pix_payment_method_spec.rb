require 'rails_helper'

feature 'Admin manages Pix payment method' do
  scenario 'successfully' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                             billing_email: 'paynow@company.com')

    login_as admin, scope: :admin

    visit root_path
    click_on 'Dashboard'
    click_on 'Pix'
    click_on 'Adicionar'
    fill_in 'Nome', with: 'Pix'
    fill_in 'Ícone', with: 'imagem no futuro'
    fill_in 'Taxa de cobrança', with: '4,5%'
    fill_in 'Taxa máxima', with: '6%'
    fill_in 'Code bank', with: '127'
    fill_in 'Code pix', with: '7f44bab8b08a3fb07555'
    click_on 'Criar Pix'

    expect(page).to have_text('Pix')
    expect(page).to have_text('imagem no futuro')
    expect(page).to have_text('4,5%')
    expect(page).to have_text('6%')
    expect(page).to have_text('127')
    expect(page).to have_text('7f44bab8b08a3fb07555')
  end

  scenario 'edit pix' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                             billing_email: 'paynow@company.com')

    paynow.pix_methods.create!(name: 'Pix', icon:'imagem', tax_charge: '3%',
                               tax_max: '4%', code_bank:'333',
                               code_pix:  '7f44bab8b08a3fb07555')

    login_as admin, scope: :admin

    visit admins_manages_path
    click_on 'Pix'
    click_on 'Editar'

    fill_in 'Nome', with: 'Pix 2'
    fill_in 'Ícone', with: 'imagem no fut'
    fill_in 'Taxa de cobrança', with: '4,5%'
    fill_in 'Taxa máxima', with: '6%'
    fill_in 'Code bank', with: '127'
    fill_in 'Code pix', with: '7f44b8b08a3fb07555'
    click_on 'Atualizar Pix'

    expect(page).to have_text('Pix 2')
    expect(page).to have_text('imagem no fut')
    expect(page).to have_text('4,5%')
    expect(page).to have_text('6%')
    expect(page).to have_text('127')
    expect(page).to have_text('7f44b8b08a3fb07555')
  end

  scenario 'edit fiels cannot be blank' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.pix_methods.create!(name: 'Pix', icon:'imagem', tax_charge: '3%',
                               tax_max: '4%', code_bank:'333',
                               code_pix:  '7f44bab8b08a3fb07555')

    login_as admin, scope: :admin

    visit admins_manages_path
    click_on 'Pix'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Taxa de cobrança', with: ''
    fill_in 'Taxa máxima', with: ''
    fill_in 'Code bank', with: ''
    fill_in 'Code pix', with: ''
    click_on 'Atualizar Pix'

    expect(page).to have_text('Nome não pode ficar em branco')
    expect(page).to have_text('Taxa de cobrança não pode ficar em branco')
    expect(page).to have_text('Taxa máxima não pode ficar em branco')
    expect(page).to have_text('Code bank não pode ficar em branco')
    expect(page).to have_text('Code pix não pode ficar em branco')

  end

  scenario 'new fiels cannot be blank' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                   billing_email: 'paynow@company.com')

    login_as admin, scope: :admin

    visit root_path
    click_on 'Dashboard'
    click_on 'Pix'
    click_on 'Adicionar'
    fill_in 'Nome', with: ''
    fill_in 'Taxa de cobrança', with: ''
    fill_in 'Taxa máxima', with: ''
    fill_in 'Code bank', with: ''
    fill_in 'Code pix', with: ''
    click_on 'Criar Pix'

    expect(page).to have_text('Nome não pode ficar em branco')
    expect(page).to have_text('Taxa de cobrança não pode ficar em branco')
    expect(page).to have_text('Taxa máxima não pode ficar em branco')
    expect(page).to have_text('Code bank não pode ficar em branco')
    expect(page).to have_text('Code pix não pode ficar em branco')
  end

  scenario 'only administrator can add pix method' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                             billing_email: 'paynow@company.com')

    login_as admin, scope: :admin

    visit root_path
    click_on 'Dashboard'
    click_on 'Pix'
    click_on 'Adicionar'
    fill_in 'Nome', with: 'Pix'
    fill_in 'Ícone', with: 'imagem no futuro'
    fill_in 'Taxa de cobrança', with: '4,5%'
    fill_in 'Taxa máxima', with: '6%'
    fill_in 'Code bank', with: '127'
    fill_in 'Code pix', with: '7f44bab8b08a3fb07555'

    logout

    click_on 'Criar Pix'

    expect(page).to have_text('Para continuar, efetue login ou registre-se')
    expect(page).to_not have_text('Pix')
    expect(page).to_not have_text('imagem no futuro')
    expect(page).to_not have_text('4,5%')
    expect(page).to_not have_text('6%')
    expect(page).to_not have_text('127')
    expect(page).to_not have_text('7f44bab8b08a3fb07555')
  end

  scenario 'only administrator can edit pix method' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap')

    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                             billing_email: 'paynow@company.com')

    paynow.pix_methods.create!(name: 'Pix', icon:'imagem', tax_charge: '3%',
                               tax_max: '4%', code_bank:'333',
                               code_pix:  '7f44bab8b08a3fb07555')

    login_as admin, scope: :admin

    visit admins_manages_path
    click_on 'Pix'
    click_on 'Editar'

    fill_in 'Nome', with: 'Pix 2'
    fill_in 'Ícone', with: 'imagem no fut'
    fill_in 'Taxa de cobrança', with: '4,5%'
    fill_in 'Taxa máxima', with: '6%'
    fill_in 'Code bank', with: '127'
    fill_in 'Code pix', with: '7f44b8b08a3fb07555'

    logout

    click_on 'Atualizar Pix'

    expect(page).to have_text('Para continuar, efetue login ou registre-se')
    expect(page).to_not have_text('Pix 2')
    expect(page).to_not have_text('imagem no fut')
    expect(page).to_not have_text('4,5%')
    expect(page).to_not have_text('6%')
    expect(page).to_not have_text('127')
    expect(page).to_not have_text('7f44b8b08a3fb07555')
  end
end
