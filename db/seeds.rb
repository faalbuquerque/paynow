puts 'Gerando Administradores do sistema(@paynow.com)'
paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                         billing_email: 'paynow@paynow.com')

maria = Admin.create!(admin_name: 'Maria', email: 'maria_admin@paynow.com',
                      password: '123456', password_confirmation: '123456')

joao = Admin.create!(admin_name: 'Joao', email: 'joao_admin@paynow.com',
                     password: '123456', password_confirmation: '123456')

puts 'Gerando Usuários do sistema(@company.com)'
company = Company.create!(cnpj: '24.098.348/0001-21',
                          corporate_name:'First company',
                          billing_email: 'company@company.com',
                          token: 'a94f3afac6f28848783f')

company.workers.create!(email: 'admin_company@company.com', password: '123456',
                        admin: true)

company.workers.create!(email: 'user_company@company.com', password: '123456',
                        admin: false)

company.workers.create!(email: 'user_block@company.com', password: '123456',
                        admin: false, status: 'block')

puts 'Gerando Métodos de pagamento(@company)'
billet = company.billet_methods.create!(name: 'Boleto Itau', tax_charge: '2',
                                        code_bank:'222', agency_bank: '999',
                                        account_number: '127.4.3.222',
                                        tax_max: '3', available: true)

card_method = company.card_methods.create!(name: 'Cartão Vis', tax_charge: '4',
                                           tax_max: '5', code:'333', available: true)

card_method = company.card_methods.create!(name: 'Cartão Mast', tax_charge: '6',
                                           tax_max: '7', code:'444', available: true)

pix_method = company.pix_methods.create!(name: 'Pix MP', tax_charge: '8',
                                         tax_max: '9', code_bank:'777',
                                         code_pix: '555', available: true)

pix_method = company.pix_methods.create!(name: 'Pix WóL', tax_charge: '10',
                                         tax_max: '11', code_bank:'888',
                                         code_pix: '111', available: false)

puts 'Gerando Produtos(@company)'
product_ruby = company.products.create!(product_name: 'Curso de ruby',
                                    product_price: '150',
                                    token: '16ab79eb59f06a07b08e')

product_rails = company.products.create!(product_name: 'Curso de rails',
                                     product_price: '210',
                                     token: '9d04efe4dc40e059c4c9')

puts 'Gerando Client'
client = Client.create!(name: 'Ana', surname: 'Souza', cpf: '333.333.333-50',
                        token: 'e7bda828ea1d64cf1a54')
