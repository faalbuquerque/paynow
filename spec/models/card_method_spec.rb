require 'rails_helper'

RSpec.describe CardMethod, type: :model do
  it { should belong_to(:company) }
end
