require 'rails_helper'

feature 'Worker admin changes workers accesses,' do
  scenario 'view administration of workers' do
    company = Company.create!(cnpj: '24.098.348/0001-21',
                              corporate_name:'Empresa',
                              billing_email: 'empresa@test.com')

    admin = company.workers.create!(email: 'admin@worker.com',
                                    password: '123456', admin: true)
    worker = company.workers.create!(email: 'worker@worker.com',
                                     password: '123456')

    login_as admin, scope: :worker

    visit root_path
    click_on 'Administração de funcionários'

    expect(current_path).to eq(workers_access_path(admin))
    expect(page).to have_content('worker@worker.com')
    expect(page).to have_link('Bloquear acesso')
  end

  scenario 'successfully' do
    company = Company.create!(cnpj: '24.098.348/0001-21',
                              corporate_name:'Empresa',
                              billing_email: 'empresa@test.com')

    admin = company.workers.create!(email: 'admin@worker.com',
                                    password: '123456', admin: true)

    worker = company.workers.create!(email: 'worker@worker.com',
                                     password: '123456')

    login_as admin, scope: :worker

    visit workers_access_path(worker)
    click_on 'Bloquear acesso'

    expect(current_path).to eq(workers_access_path(worker))
    expect(page).to have_content('Acesso bloqueado para worker@worker.com!')
    expect(page).to_not have_content('Bloquear acesso')
    expect(page).to have_content('Desbloquear acesso')
  end

  scenario 'blocked worker tries to login' do
    company = Company.create!(cnpj: '24.098.348/0001-21',
                              corporate_name:'Empresa',
                              billing_email: 'empresa@test.com')

    worker = company.workers.create!(email: 'worker@worker.com',
                                     password: '123456', status: 'block')

    visit new_worker_session_path

    fill_in 'Email', with: 'worker@worker.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'

    expect(current_path).to eq(new_worker_session_path)
    expect(page).to have_content('Sua conta está bloqueada!')
    expect(page).to_not have_content('worker@worker.com')
    expect(page).to_not have_content('Sair')
  end

  scenario 'released worker tries to login' do
    company = Company.create!(cnpj: '24.098.348/0001-21',
                              corporate_name:'Empresa',
                              billing_email: 'empresa@test.com')

    worker = company.workers.create!(email: 'worker@worker.com',
                                     password: '123456')

    login_as worker, scope: :worker
    visit root_path

    expect(current_path).to_not eq(new_worker_session_path)
    expect(page).to have_content('worker@worker.com')
    expect(page).to have_content('Sair')
  end

  scenario 'admin from another company tries to access' do
    company = Company.create!(cnpj: '24.098.348/0001-21',
                              corporate_name:'Empresa',
                              billing_email: 'empresa@test.com')

    worker = company.workers.create!(email: 'worker@worker.com',
                                     password: '123456', admin: true)

    another_worker = company.workers.create!(email: 'a_worker@worker.com',
                                             password: '123456')

    other_company = Company.create!(cnpj: '25.098.348/0001-21',
                                    corporate_name:'Outra empresa',
                                    billing_email: 'outra@empresa.com')

    other = other_company.workers.create!(email: 'other@othercompany.com',
                                          password: '123456', admin: true)

    login_as other, scope: :worker
    visit workers_access_path(worker)

    expect(page).to have_content('other@othercompany.com')
    expect(page).to_not have_content('a_worker@worker.com')
  end

  scenario 'visitor try to acess as not logged in' do
    company = Company.create!(cnpj: '24.098.348/0001-21',
                              corporate_name:'Empresa',
                              billing_email: 'empresa@test.com')

    worker = company.workers.create!(email: 'worker@worker.com',
                                     password: '123456', admin: true)

    visit workers_access_path(worker)

    expect(current_path).to eq(new_worker_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end
end
