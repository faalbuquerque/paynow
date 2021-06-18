require 'rails_helper'

RSpec.describe CompanyToken, type: :model do
  it { should belong_to(:client) }
end
