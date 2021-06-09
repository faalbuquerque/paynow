require 'rails_helper'

feature 'Visitor registers in the system' do
  scenario 'successfully' do
    visit root_path
    click_on 'Faça seu cadastro'

    fill_in 'Email', with: 'worker@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    fill_in 'CNPJ', with: '57.065.291/0001-13'
    fill_in 'Nome da Empresa', with: 'Codeplay'
    fill_in 'Email de cobrança', with: 'codeplay@email.com'
    fill_in 'País', with: 'Brasil'
    fill_in 'CEP', with: '06666-666'
    fill_in 'Estado', with: 'São Paulo'
    fill_in 'Cidade', with: 'Maua'
    fill_in 'Rua', with: 'Rua do teste'
    fill_in 'Número', with: '777'
    fill_in 'Complemento', with: 'Apto 13'

    click_on 'Criar conta'

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Login efetuado com sucesso')
    expect(page).to have_text('worker@email.com')
    expect(page).to have_link('Sair')
    expect(page).to_not have_text('Faça seu cadastro')
  end

  scenario 'and company data cannot be blank' do
    visit new_worker_registration_path

    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmar senha', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Nome da Empresa', with: ''
    fill_in 'Email de cobrança', with: ''
    fill_in 'País', with: 'Brasil'
    fill_in 'CEP', with: '06666-666'
    fill_in 'Estado', with: 'São Paulo'
    fill_in 'Cidade', with: 'Maua'
    fill_in 'Rua', with: 'Rua do teste'
    fill_in 'Número', with: '777'
    fill_in 'Complemento', with: 'Apto 13'

    click_on 'Criar conta'

    expect(current_path).to eq(worker_registration_path)
    expect(page).to have_text('Email não pode ficar em branco')
    expect(page).to have_text('Senha não pode ficar em branco')
    expect(page).to have_text('Preencher Dados da Empresa é obrigatório(a)')
    expect(page).to have_text('CNPJ não pode ficar em branco')
    expect(page).to have_text('Nome da Empresa não pode ficar em branco')
    expect(page).to have_text('Email de cobrança não pode ficar em branco' )
  end

  scenario 'and billing address cannot be blank' do
    visit new_worker_registration_path

    fill_in 'Email', with: 'worker@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    fill_in 'CNPJ', with: '57.065.291/0001-13'
    fill_in 'Nome da Empresa', with: 'Codeplay'
    fill_in 'Email de cobrança', with: 'codeplay@email.com'
    fill_in 'País', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Estado', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Rua', with: ''
    fill_in 'Número', with: ''
    fill_in 'Complemento', with: ''

    click_on 'Criar conta'

    expect(current_path).to eq(worker_registration_path)
    expect(page).to have_text('País não pode ficar em branco')
    expect(page).to have_text('CEP não pode ficar em branco')
    expect(page).to have_text('Estado não pode ficar em branco')
    expect(page).to have_text('Cidade não pode ficar em branco')
    expect(page).to have_text('Rua não pode ficar em branco')
    expect(page).to have_text('Número não pode ficar em branco')
  end

  scenario 'and password not match' do
    visit new_worker_registration_path
    fill_in 'Email', with: 'worker@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: 'a1s2d4f5'
    click_on 'Criar conta'

    expect(page).to have_text('Confirmar senha não é igual a Senha')
    expect(current_path).to eq(worker_registration_path)
  end

  scenario 'and email not unique' do
    company = Company.create!(cnpj: '57.065.291/0001-13',
                              corporate_name: 'Codeplay',
                              billing_email: 'code@email.com')
    Worker.create!(email:'worker@email.com', password: '123456',
                   password_confirmation: '123456', company: company)

    visit new_worker_registration_path
    fill_in 'Email', with: 'worker@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    click_on 'Criar conta'

    expect(current_path).to eq(worker_registration_path)
    expect(page).to have_text('Email já está em uso')
  end

  xscenario 'gmail accounts cannot be used' do
    visit new_worker_registration_path

    fill_in 'Email', with: 'worker@gmail.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    click_on 'Criar conta'

    expect(current_path).to eq(worker_registration_path)
    expect(page).to have_text('Email não é válido')
  end

  xscenario 'yahoo accounts cannot be used' do
    visit new_worker_registration_path

    fill_in 'Email', with: 'worker@yahoo.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    click_on 'Criar conta'

    expect(current_path).to eq(worker_registration_path)
    expect(page).to have_text('Email não é válido')
  end

  xscenario 'hotmail accounts cannot be used' do
    visit new_worker_registration_path

    fill_in 'Email', with: 'worker@hotmail.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    click_on 'Criar conta'

    expect(current_path).to eq(worker_registration_path)
    expect(page).to have_text('Email não é válido')
  end
end

