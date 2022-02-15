require 'rails_helper'
require 'vcr_setup'

RSpec.describe 'Search a monster using D&D 5e API', type: :feature do
  scenario 'valid inputs', :vcr do
    visit new_monster_path
    fill_in 'search', with: 'Bandit'
    click_button 'Search Monster'
    expect(page).to have_content('Bandit')
  end
end
