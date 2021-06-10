require 'rails_helper'

feature 'Admin logs into the system' do
  scenario 'and is recognized as an Paynow admin' do
    Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                  password:'wonyap', password_confirmation:'wonyap')

    visit root_path
    click_on 'Faça login'

    fill_in 'Email', with: 'potato@paynow.com'
    fill_in 'Senha', with: 'wonyap'
    click_on 'Entrar'

    expect(current_path).to eq(new_admin_session_path)
    expect(page).to have_text('Login de Admin')
  end

  scenario 'successfully' do
    Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                  password:'wonyap', password_confirmation:'wonyap')

    visit new_admin_session_path

    fill_in 'Email', with: 'potato@paynow.com'
    fill_in 'Senha', with: 'wonyap'
    click_on 'Entrar'

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Login efetuado com sucesso')
    expect(page).to have_text('potato@paynow.com')
    expect(page).to have_link('Sair')
  end

  scenario 'and data cannot be blank' do
    visit new_admin_session_path

    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    click_on 'Entrar'

    expect(current_path).to eq(new_admin_session_path)
    expect(page).to have_text('Email ou senha inválida')
  end

  scenario 'and passwords not match' do
    Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                  password:'wonyap', password_confirmation:'wonyap')

    visit new_admin_session_path

    fill_in 'Email', with: 'admin@paynow.com'
    fill_in 'Senha', with: 'a1s2d3f4'
    click_on 'Entrar'

    expect(current_path).to eq(new_admin_session_path)
    expect(page).to have_text('Email ou senha inválida')
  end

  scenario 'and check if admin' do
    admin = Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                          password:'wonyap', password_confirmation:'wonyap')

    login_as admin, scope: :admin
    visit admin_session_path

    expect(current_path).to eq(root_path)
    expect(page).to have_text('potato@paynow.com')
    expect(page).to have_link('Dashboard')
  end
end
