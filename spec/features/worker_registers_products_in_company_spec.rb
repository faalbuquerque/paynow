require 'rails_helper'

feature 'Worker registers products in company' do
  scenario 'view products' do
    company = Company.create!(cnpj: '24.098.348/0001-21',
                              corporate_name:'Empresa',
                              billing_email: 'empresa@test.com')

    worker = company.workers.create!(email: 'worker@worker.com',
                                     password: '123456')

    product_ruby = company.products.new(product_name: 'Curso de ruby',
                                        product_price: '150')
    product_ruby.create_token
    product_ruby.save!

    product_rails = company.products.new(product_name: 'Curso de rails',
                                         product_price: '100')
    product_rails.create_token
    product_rails.save!

    login_as worker, scope: :worker
    visit workers_company_path(company)
    click_on 'Produtos'

    expect(page).to have_content('Curso de ruby')
    expect(page).to have_content('Curso de rails')
  end

  scenario 'add new product' do
    company = Company.create!(cnpj: '24.098.348/0001-21',
                              corporate_name:'Empresa',
                              billing_email: 'empresa@test.com')

    worker = company.workers.create!(email: 'worker@worker.com',
                                     password: '123456')

    login_as worker, scope: :worker
    visit products_path(company)
    click_on 'Adicionar novo produto'

    fill_in 'Nome', with: 'Curso de Rails'
    fill_in 'Preço', with: '150'
    click_on 'Criar Produto'

    expect(page).to have_text('Produto adicionado com sucesso!')
    expect(page).to have_text('Curso de Rails')
    expect(page).to have_text('Preço: 150,00')
    expect(page).to have_content(Product.first.token)
  end

  scenario 'edit product' do
    company = Company.create!(cnpj: '24.098.348/0001-21',
                              corporate_name:'Empresa',
                              billing_email: 'empresa@test.com')

    worker = company.workers.create!(email: 'worker@worker.com',
                                     password: '123456')

    product_ruby = company.products.new(product_name: 'Curso de ruby',
                                        product_price: '150')
    product_ruby.create_token
    product_ruby.save!

    login_as worker, scope: :worker
    visit products_path(company)
    click_on 'Editar Produto'

    fill_in 'Nome', with: 'Curso de JavaScript'
    fill_in 'Preço', with: '250'
    click_on 'Atualizar Produto'

    expect(page).to have_text('Produto alterado com sucesso!')
    expect(page).to have_text('Curso de JavaScript')
    expect(page).to have_text('250,00')
    expect(page).to have_text(product_ruby.token)
  end

  scenario 'new product cannot be blank' do
    company = Company.create!(cnpj: '24.098.348/0001-21',
                              corporate_name:'Empresa',
                              billing_email: 'empresa@test.com')

    worker = company.workers.create!(email: 'worker@worker.com',
                                     password: '123456')

    login_as worker, scope: :worker
    visit new_product_path(company)

    fill_in 'Nome', with: ''
    fill_in 'Preço', with: ''
    click_on 'Criar Produto'

    expect(current_path).to eq(products_path)
    expect(page).to have_text('Nome não pode ficar em branco')
    expect(page).to have_text('Preço não pode ficar em branco')
  end

  scenario 'edit product cannot be blank' do
    company = Company.create!(cnpj: '24.098.348/0001-21',
                              corporate_name:'Empresa',
                              billing_email: 'empresa@test.com')

    worker = company.workers.create!(email: 'worker@worker.com',
                                     password: '123456')

    product_ruby = company.products.create!(product_name: 'Curso de ruby',
                                        product_price: '150')

    login_as worker, scope: :worker
    visit edit_product_path(product_ruby)

    fill_in 'Nome', with: ''
    fill_in 'Preço', with: ''
    click_on 'Atualizar Produto'

    expect(page).to have_text('Nome não pode ficar em branco')
    expect(page).to have_text('Preço não pode ficar em branco')
  end

  scenario 'add discount in product' do
    company = Company.create!(cnpj: '24.098.348/0001-21',
                              corporate_name:'Empresa',
                              billing_email: 'empresa@test.com')

    worker = company.workers.create!(email: 'worker@worker.com',
                                     password: '123456')

    product_ruby = company.products.create!(product_name: 'Curso de ruby',
                                            product_price: '150')


    pix_method = company.pix_methods.create!(name: 'Pix', tax_charge: '10',
                                            tax_max: '11', code_bank:'888',
                                            code_pix: '111', available: true)
    login_as worker, scope: :worker

    visit product_path(product_ruby)

    click_on 'Adicionar desconto'

    fill_in 'Desconto', with: '5'
    select 'Pix', from: 'discount_payment_type'
    click_on 'Criar Desconto'

    expect(page).to have_content('Curso de ruby')
    expect(page).to have_content('150,00')
    expect(page).to have_content('5,00')
    expect(page).to have_content('Pix')
  end

  scenario 'add discount in product cannot be blank' do
    company = Company.create!(cnpj: '24.098.348/0001-21',
                              corporate_name:'Empresa',
                              billing_email: 'empresa@test.com')

    worker = company.workers.create!(email: 'worker@worker.com',
                                     password: '123456')

    product_ruby = company.products.create!(product_name: 'Curso de ruby',
                                            product_price: '150')


    pix_method = company.pix_methods.create!(name: 'Pix', tax_charge: '10',
                                            tax_max: '11', code_bank:'888',
                                            code_pix: '111', available: true)
    login_as worker, scope: :worker

    visit product_path(product_ruby)

    click_on 'Adicionar desconto'

    fill_in 'Desconto', with: ''
    click_on 'Criar Desconto'

    expect(page).to have_content('Desconto não pode ficar em branco')
    expect(page).to_not have_content('Curso de ruby')
    expect(page).to_not have_content('150')
  end
end
