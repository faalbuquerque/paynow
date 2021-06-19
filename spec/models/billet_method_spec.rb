require 'rails_helper'

RSpec.describe BilletMethod, type: :model do
  it { should belong_to(:company) }
end
