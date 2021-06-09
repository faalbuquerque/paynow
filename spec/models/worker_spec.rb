require 'rails_helper'

RSpec.describe Worker, type: :model do
  it { should belong_to(:company) }
  it { should have_db_column(:admin) }
end
