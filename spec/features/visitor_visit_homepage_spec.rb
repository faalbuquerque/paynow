require 'rails_helper'

feature 'Visitor visit Homepage' do
  scenario 'successfully' do
    visit root_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content('PayNow')
  end
end
