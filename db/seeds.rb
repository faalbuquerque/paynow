@paynow = Company.create(cnpj: '24.098.348/0001-21', corporate_name:'Paynow',
                         billing_email: 'paynow@company.com')

maria = Admin.create!(admin_name: 'Maria', email: 'maria_admin@paynow.com',
                      password: '123456', password_confirmation: '123456')

joao = Admin.create!(admin_name: 'Joao', email: 'joao_admin@paynow.com',
                     password: '123456', password_confirmation: '123456')

company = Company.new(cnpj: '24.098.348/0001-21',
                      corporate_name:'First company',
                      billing_email: 'company@company.com')
company.create_token
company.save!

company.workers.create!(email: 'admin_company@company.com', password: '123456',
                        admin: true)

company.workers.create!(email: 'user_company@company.com', password: '123456',
                        admin: false)

company.workers.create!(email: 'user_block@company.com', password: '123456',
                        admin: false, status: 'block')
