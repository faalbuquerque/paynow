require 'rails_helper'

RSpec.describe PixMethod, type: :model do
  it { should belong_to(:company) }
end
