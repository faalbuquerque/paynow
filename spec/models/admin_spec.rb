require 'rails_helper'

RSpec.describe Manages::AdminsController, type: :controller do
  it { should use_before_action(:authenticate_admin!) }
  it { should route(:get, '/manages/admins').to(action: :index) }
end