require 'rails_helper'
require 'vcr_setup'

RSpec.describe 'Search a monster using D&D 5e API', type: :feature, js: true do

  let(:bat_attributes) do
    {
      name: 'Bat',
      size: 'Tiny',
      species: 'Beast',
      alignment: 'unaligned',
      armor_class: '12',
      hit_points: 1,
      hit_dice: '1d4',
      ability_scores: {
        strength: 2,
        dexterity: 15,
        constitution: 8,
        intelligence: 2,
        wisdom: 12,
        charisma: 4
      },
      challenge_rating: '0',
      xp: 10,
      proficiency_bonus: 2
    }
  end

  scenario 'valid inputs and save', :vcr do
    visit new_monster_path
    fill_in 'search', with: 'Bat'
    click_button 'Search Monster'
    expect(page).to have_css '.alert-success'
    expect {
      click_button 'Create Monster'
    }.to change(Monster, :count).by(1)
    expect(Monster.where(name: 'Bat')).to exist
  end

  scenario 'invalid inputs', :vcr do
    visit new_monster_path
    fill_in 'search', with: 'pikachu'
    click_button 'Search Monster'
    expect(page).to have_css '.alert-danger'
  end

  scenario 'duplicate monster and update', :vcr do
    Monster.create! bat_attributes
    visit new_monster_path
    fill_in 'search', with: 'Bat'
    click_button 'Search Monster'
    expect(page).to have_css '.alert-warning'
    expect {
      click_button 'Update Monster'
    }.to change(Monster, :count).by(0)
  end
end
