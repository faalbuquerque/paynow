require 'rails_helper'

feature 'Worker admin alter token', type: :request do
  scenario 'successfully' do
    company = Company.new(cnpj: '24.098.348/0001-21',
                          corporate_name:'Company',
                          billing_email: 'company@company.com')
    company.create_token
    company.save!

    old_token = company.token

    worker_admin = company.workers.create!(email: 'worker@company.com',
                                           password: '123456', admin: true)

    javascript_replacement_function = '(\'#company_token\').innerHTML ='

    login_as worker_admin, scope: :worker

    put '/workers/company/alter-token', xhr: true

    expect(response.body).to_not include(old_token)
    expect(response.body).to include(javascript_replacement_function)
    expect(response.body).to include(worker_admin.company.token)
  end

  scenario 'require admin' do
    company = Company.new(cnpj: '24.098.348/0001-21',
                          corporate_name:'Company',
                          billing_email: 'company@company.com')
    company.create_token
    company.save!

    token = company.token

    worker = company.workers.create!(email: 'worker@company.com',
                                           password: '123456', admin: false)

    javascript_replacement_function = '(\'#company_token\').innerHTML ='

    login_as worker, scope: :worker

    put '/workers/company/alter-token', xhr: true

    expect(response.body).to_not include(token)
    expect(response.body).to_not include(javascript_replacement_function)
  end
end
