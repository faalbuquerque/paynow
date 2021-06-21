require 'rails_helper'

RSpec.describe Discount, type: :model do
  it { should belong_to(:product) }
end
