require 'rails_helper'

RSpec.describe BillingAddress, type: :model do
  it { should belong_to(:company) }
end
