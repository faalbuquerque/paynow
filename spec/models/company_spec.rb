require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should have_many(:workers) }
  it { should have_db_column(:domain) }
  it { should have_db_column(:token) }
end
