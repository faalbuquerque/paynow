require 'rails_helper'

feature 'Admin try to log in' do
  scenario 'successfully' do
    Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                  password:'wonyap', password_confirmation:'wonyap')

    visit new_worker_session_path

    fill_in 'Email', with: 'potato@paynow.com'
    fill_in 'Senha', with: 'wonyap'
    click_on 'Entrar'

    expect(current_path).to eq(root_path)
    expect(page).to have_text('potato@paynow.com')
    expect(page).to have_link('Sair')
  end

  scenario 'and data cannot be blank' do
    visit new_worker_session_path

    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    click_on 'Entrar'

    expect(current_path).to eq(new_worker_session_path)
    expect(page).to have_text('Email ou senha inválida')
  end

  scenario 'password doesn\'t match' do
    Admin.create!(admin_name: 'Potato', email: 'potato@paynow.com',
                  password:'wonyap', password_confirmation:'wonyap')

    visit new_worker_session_path

    fill_in 'Email', with: 'potato@paynow.com'
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
