require 'rails_helper'

feature 'Worker view token' do
  scenario 'successfully' do
    company = Company.new(cnpj: '24.098.348/0001-21',
                          corporate_name:'Company',
                          billing_email: 'company@company.com')
    company.create_token
    company.save!

    worker = company.workers.create!(email: 'worker@company.com',
                                     password: '123456')

    login_as worker, scope: :worker

    visit root_path
    click_on 'Minha empresa'

    expect(current_path).to eq(workers_company_path(worker))
    expect(page).to have_content('Dados da Empresa')
    expect(page).to have_content(company.token)
  end

  scenario 'view only own company token' do
    company_uol = Company.new(cnpj: '24.098.348/0001-21',
                              corporate_name:'Uol',
                              billing_email: 'uol@company_uol.com')
    company_uol.create_token
    company_uol.save!

    company_bol = Company.new(cnpj: '73.892.118/0001-45',
                              corporate_name:'Bol',
                              billing_email: 'bol@company_bol.com')
    company_bol.create_token
    company_bol.save!

    worker_uol = company_uol.workers.create!(email: 'worker@uol.com',
                                             password: '123456')

    worker_bol = company_bol.workers.create!(email: 'worker@bol.com',
                                             password: '123456')

    login_as worker_bol, scope: :worker

    visit workers_company_path(company_uol)

    expect(page).to_not have_content(company_uol.token)
    expect(page).to have_content(company_bol.token)
  end
end
