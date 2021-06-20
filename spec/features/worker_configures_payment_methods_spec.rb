require 'rails_helper'

feature 'Worker configures payment methods' do
  scenario 'add billet' do
    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.billet_methods.create!(name: 'Boleto', tax_charge: '3', tax_max: '4',
                                  code_bank:'333', agency_bank: '333',
                                  account_number:'127.4.3.222', available: true)

    paynow.billet_methods.create!(name: 'Boleto Itau', tax_charge: '3', tax_max: '4',
                                  code_bank:'333', agency_bank: '333',
                                  account_number:'127.4.3.222', available: true)

    company = Company.create(cnpj: '24.198.348/0001-21', corporate_name:'Company',
                             billing_email: 'company@company.com')

    worker = company.workers.create!(email: 'worker@company.com',
                                     password: '123456')

    login_as worker, scope: :worker
    visit workers_company_path(company)
    click_on 'Gerenciar metodos de pagamento'
    click_on 'Adicionar Boleto'

    fill_in 'Código do banco', with: '123'
    fill_in 'Número de agencia', with: '123.456'
    fill_in 'Número da conta', with: '666'
    select 'Boleto Itau', from: 'BilletMethod_id'
    click_on 'Criar Boleto'

    expect(page).to have_text('Metodo de pagamento adicionado!')
    expect(page).to have_text('Boleto Itau')
    expect(page).to have_text('Taxa cobrança: 3%')
    expect(page).to have_text('Taxa max: 4%')
    expect(page).to have_text('Código do banco: 123')
    expect(page).to have_text('Agência: 123.456')
    expect(page).to have_text('Conta: 666')
  end

  scenario 'add card' do
    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.card_methods.create!(name: 'Cartão Vis', tax_charge: '3', tax_max: '4',
                                code:'333', available: true)

    paynow.card_methods.create!(name: 'Cartão Mast', tax_charge: '3', tax_max: '4',
                                code:'333', available: true)

    company = Company.create(cnpj: '24.198.348/0001-21', corporate_name:'Company',
                             billing_email: 'company@company.com')

    worker = company.workers.create!(email: 'worker@company.com',
                                     password: '123456')

    login_as worker, scope: :worker
    visit workers_company_path(company)
    click_on 'Gerenciar metodos de pagamento'
    click_on 'Adicionar Cartao de Crédito'

    fill_in 'Código do banco', with: '123'
    select 'Cartão Mast', from: 'CardMethod_id'
    click_on 'Criar Cartão'

    expect(page).to have_text('Metodo de pagamento adicionado!')
    expect(page).to have_text('Cartão Mast')
    expect(page).to have_text('Taxa cobrança: 3%')
    expect(page).to have_text('Taxa max: 4%')
    expect(page).to have_text('Código do banco: 123')
  end

  scenario 'add pix' do
    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.pix_methods.create!(name: 'Pix', tax_charge: '3', tax_max: '4',
                               code_bank:'333', code_pix: '333', available: true)

    paynow.pix_methods.create!(name: 'Pix MP', tax_charge: '3', tax_max: '4',
                              code_bank:'333', code_pix: '333', available: true)

    company = Company.create(cnpj: '24.198.348/0001-21', corporate_name:'Company',
                             billing_email: 'company@company.com')

    worker = company.workers.create!(email: 'worker@company.com',
                                     password: '123456')

    login_as worker, scope: :worker
    visit workers_company_path(company)
    click_on 'Gerenciar metodos de pagamento'
    click_on 'Adicionar Pix'

    fill_in 'Código do banco', with: '123'
    fill_in 'Código Pix', with: 'a1s2d3f4g5h6'
    select 'Pix MP', from: 'PixMethod_id'
    click_on 'Criar Pix'

    expect(page).to have_text('Metodo de pagamento adicionado!')
    expect(page).to have_text('Pix MP')
    expect(page).to have_text('Taxa cobrança: 3%')
    expect(page).to have_text('Taxa max: 4%')
    expect(page).to have_text('Código do banco: 123')
    expect(page).to have_text('Código Pix: a1s2d3f4g5h6')
  end

  scenario 'add billet cannot be blank' do
    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.billet_methods.create!(name: 'Boleto', tax_charge: '3', tax_max: '4',
                                  code_bank:'333', agency_bank: '333',
                                  account_number:'127.4.3.222', available: true)

    paynow.billet_methods.create!(name: 'Boleto Itau', tax_charge: '3', tax_max: '4',
                                  code_bank:'333', agency_bank: '333',
                                  account_number:'127.4.3.222', available: true)

    company = Company.create(cnpj: '24.198.348/0001-21', corporate_name:'Company',
                             billing_email: 'company@company.com')

    worker = company.workers.create!(email: 'worker@company.com',
                                     password: '123456')

    login_as worker, scope: :worker
    visit workers_company_path(company)
    click_on 'Gerenciar metodos de pagamento'
    click_on 'Adicionar Boleto'

    fill_in 'Código do banco', with: ''
    fill_in 'Número de agencia', with: ''
    fill_in 'Número da conta', with: ''
    select 'Boleto Itau', from: 'BilletMethod_id'
    click_on 'Criar Boleto'

    expect(page). to have_text('não pode ficar em branco', count: 3)
    expect(page). to have_text('Erro ao criar methodo de pagamento!')
  end

  scenario 'add card cannot be blank' do
    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.card_methods.create!(name: 'Cartão Vis', tax_charge: '3', tax_max: '4',
                                code:'333', available: true)

    paynow.card_methods.create!(name: 'Cartão Mast', tax_charge: '3', tax_max: '4',
                                code:'333', available: true)

    company = Company.create(cnpj: '24.198.348/0001-21', corporate_name:'Company',
                             billing_email: 'company@company.com')

    worker = company.workers.create!(email: 'worker@company.com',
                                     password: '123456')

    login_as worker, scope: :worker
    visit workers_company_path(company)
    click_on 'Gerenciar metodos de pagamento'
    click_on 'Adicionar Cartao de Crédito'

    fill_in 'Código do banco', with: ''
    select 'Cartão Mast', from: 'CardMethod_id'
    click_on 'Criar Cartão'

    expect(page). to have_text('não pode ficar em branco', count: 1)
    expect(page). to have_text('Erro ao criar methodo de pagamento!')
  end

  scenario 'add pix cannot be blank' do
    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.pix_methods.create!(name: 'Pix', tax_charge: '3', tax_max: '4',
                               code_bank:'333', code_pix: '333', available: true)

    paynow.pix_methods.create!(name: 'Pix MP', tax_charge: '3', tax_max: '4',
                              code_bank:'333', code_pix: '333', available: true)

    company = Company.create(cnpj: '24.198.348/0001-21', corporate_name:'Company',
                             billing_email: 'company@company.com')

    worker = company.workers.create!(email: 'worker@company.com',
                                     password: '123456')

    login_as worker, scope: :worker
    visit workers_company_path(company)
    click_on 'Gerenciar metodos de pagamento'
    click_on 'Adicionar Pix'

    fill_in 'Código do banco', with: ''
    fill_in 'Código Pix', with: ''
    select 'Pix MP', from: 'PixMethod_id'
    click_on 'Criar Pix'

    expect(page). to have_text('não pode ficar em branco', count: 2)
    expect(page). to have_text('Erro ao criar methodo de pagamento!')
  end

  scenario 'edit billet' do
    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.billet_methods.create!(name: 'Boleto Bradesco', tax_charge: '3', tax_max: '4',
                                  code_bank:'333', agency_bank: '333',
                                  account_number:'127.4.3.222', available: true)

    company = Company.create(cnpj: '24.198.348/0001-21', corporate_name:'Company',
                             billing_email: 'company@company.com')

    billet = company.billet_methods
                    .create!(name: 'Boleto Bradesco', tax_charge: '3', tax_max: '4',
                             code_bank:'333', agency_bank: '333',
                             account_number:'127.4.3.222', available: true)

    worker = company.workers.create!(email: 'worker@company.com',
                                     password: '123456')

    login_as worker, scope: :worker
    visit workers_payment_methods_path
    click_on 'Editar'

    fill_in 'Código do banco', with: '1234'
    fill_in 'Número de agencia', with: '1234.4567'
    fill_in 'Número da conta', with: '666777'
    click_on 'Atualizar Boleto'

    expect(page).to have_text('Metodo de pagamento atualizado!')
    expect(page).to have_text('Boleto')
    expect(page).to have_text('Taxa cobrança: 3%')
    expect(page).to have_text('Taxa max: 4%')
    expect(page).to have_text('Código do banco: 1234')
    expect(page).to have_text('Agência: 1234.4567')
    expect(page).to have_text('Conta: 666777')
  end

  scenario 'edit card' do
    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.card_methods.create!(name: 'Cartão de credito', tax_charge: '3',
                                tax_max: '4', code:'333', available: true)

    company = Company.create(cnpj: '24.198.348/0001-21', corporate_name:'Company',
                             billing_email: 'company@company.com')

    card = company.card_methods.create!(name: 'Cartão de credito',
                                        tax_charge: '3', tax_max: '4',
                                        code:'333', available: true)

    worker = company.workers.create!(email: 'worker@company.com',
                                     password: '123456')

    login_as worker, scope: :worker
    visit workers_payment_methods_path
    click_on 'Editar'

    fill_in 'Código do banco', with: '1235'
    click_on 'Atualizar Cartão'

    expect(page).to have_text('Metodo de pagamento atualizado!')
    expect(page).to have_text('Cartão de credito')
    expect(page).to have_text('Taxa cobrança: 3%')
    expect(page).to have_text('Taxa max: 4%')
    expect(page).to have_text('Código do banco: 1235')
  end

  scenario 'edit pix' do
    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.pix_methods.create!(name: 'Pix', tax_charge: '3', tax_max: '4',
                               code_bank:'333', code_pix: '333', available: true)

    company = Company.create(cnpj: '24.198.348/0001-21', corporate_name:'Company',
                             billing_email: 'company@company.com')

    worker = company.workers.create!(email: 'worker@company.com',
                                     password: '123456')

    pix = company.pix_methods.create!(name: 'Pix', tax_charge: '3', tax_max: '4',
                                      code_bank: '444', code_pix:'456',
                                      available: true)

    login_as worker, scope: :worker
    visit workers_payment_methods_path
    click_on 'Editar'

    fill_in 'Código do banco', with: '789'
    fill_in 'Código Pix', with: 'f4g5h6'
    click_on 'Atualizar Pix'

    expect(page). to have_text('Metodo de pagamento atualizado!')
    expect(page). to have_text('Pix')
    expect(page). to have_text('Taxa cobrança: 3%')
    expect(page). to have_text('Taxa max: 4%')
    expect(page). to have_text('Código do banco: 789')
    expect(page). to have_text('Código Pix: f4g5h6')
  end

  scenario 'billet edit cannot be blank' do
    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.billet_methods.create!(name: 'Boleto Bradesco', tax_charge: '3', tax_max: '4',
                                  code_bank:'333', agency_bank: '333',
                                  account_number:'127.4.3.222', available: true)

    company = Company.create(cnpj: '24.198.348/0001-21', corporate_name:'Company',
                             billing_email: 'company@company.com')

    billet = company.billet_methods
                    .create!(name: 'Boleto Bradesco', tax_charge: '3', tax_max: '4',
                             code_bank:'333', agency_bank: '333',
                             account_number:'127.4.3.222', available: true)

    worker = company.workers.create!(email: 'worker@company.com',
                                     password: '123456')

    login_as worker, scope: :worker
    visit workers_payment_methods_path
    click_on 'Editar'

    fill_in 'Código do banco', with: ''
    fill_in 'Número de agencia', with: ''
    fill_in 'Número da conta', with: ''
    click_on 'Atualizar Boleto'

    expect(page). to have_text('Não foi possivel atualizar!')
    expect(page). to have_text('não pode ficar em branco', count: 3)
  end

  scenario 'card edit cannot be blank' do
    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.card_methods.create!(name: 'Cartão de credito', tax_charge: '3',
                                tax_max: '4', code:'333', available: true)

    company = Company.create(cnpj: '24.198.348/0001-21', corporate_name:'Company',
                             billing_email: 'company@company.com')

    card = company.card_methods.create!(name: 'Cartão de credito',
                                        tax_charge: '3', tax_max: '4',
                                        code:'333', available: true)

    worker = company.workers.create!(email: 'worker@company.com',
                                     password: '123456')

    login_as worker, scope: :worker
    visit workers_payment_methods_path
    click_on 'Editar'

    fill_in 'Código do banco', with: ''
    click_on 'Atualizar Cartão'

    expect(page). to have_text('não pode ficar em branco', count: 1)
    expect(page). to have_text('Não foi possivel atualizar!')
  end

  scenario 'pix edit cannot be blank' do
    paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                            billing_email: 'paynow@company.com')

    paynow.pix_methods.create!(name: 'Pix', tax_charge: '3', tax_max: '4',
                               code_bank:'333', code_pix: '333', available: true)

    company = Company.create(cnpj: '24.198.348/0001-21', corporate_name:'Company',
                             billing_email: 'company@company.com')

    worker = company.workers.create!(email: 'worker@company.com',
                                     password: '123456')

    pix = company.pix_methods.create!(name: 'Pix', tax_charge: '3', tax_max: '4',
                                      code_bank: '444', code_pix:'456',
                                      available: true)

    login_as worker, scope: :worker
    visit workers_payment_methods_path
    click_on 'Editar'

    fill_in 'Código do banco', with: ''
    fill_in 'Código Pix', with: ''
    click_on 'Atualizar Pix'

    expect(page). to have_text('não pode ficar em branco', count: 2)
    expect(page). to have_text('Não foi possivel atualizar!')
  end
end
