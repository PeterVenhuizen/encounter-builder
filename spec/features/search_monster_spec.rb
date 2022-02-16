require 'rails_helper'
require 'vcr_setup'

RSpec.describe 'Search a monster using D&D 5e API', type: :feature, js: true do

  let(:bandit_attributes) do
    {
      name: 'Bandit',
      size: 'Medium',
      species: 'Humanoid',
      alignment: 'any non-lawful alignment',
      armor_class: '12 (leather armor)',
      hit_points: 11,
      hit_dice: '2d8 + 2',
      ability_scores: {
        strength: 11,
        dexterity: 12,
        constitution: 12,
        intelligence: 10,
        wisdom: 10,
        charisma: 10
      },
      challenge_rating: '1/8',
      xp: 25,
      proficiency_bonus: 2
    }
  end

  scenario 'valid inputs and save', :vcr do
    visit new_monster_path
    fill_in 'search', with: 'Bandit'
    click_button 'Search Monster'
    expect(page).to have_css '.alert.alert-success'
    click_button 'Create Monster'
    expect(Monster.where(name: 'Bandit')).to exist
  end

  scenario 'invalid inputs', :vcr do
    visit new_monster_path
    fill_in 'search', with: 'sdfsdjf'
    click_button 'Search Monster'
    expect(page).to have_css '.alert.alert-danger'
  end

  scenario 'duplicate monster and update', :vcr do
    Monster.create! bandit_attributes
    visit new_monster_path
    fill_in 'search', with: 'Bandit'
    click_button 'Search Monster'
    expect(page).to have_css '.alert.alert-warning'
    expect {
      click_button 'Update Monster'
    }.to change(Monster, :count).by(0)
  end
end
