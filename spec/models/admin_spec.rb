require 'rails_helper'

RSpec.describe Admins::ManagesController, type: :controller do
  it { should use_before_action(:authenticate_admin!) }
  it { should route(:get, '/admins/manages').to(action: :index) }
end

RSpec.describe Admin, type: :model do
  context 'should check if' do
    it 'typed correct password' do
      admin = Admin.create!(email: 'potato@paynow.com', password:'wonyap')

      expect(admin.correct_password?('wonyap')).to be_truthy
    end

    it 'typed wrong password' do
      admin = Admin.create!(email: 'potato@paynow.com', password:'wonyap')

      expect(admin.correct_password?('123456')).to be_falsy
    end
  end
end
