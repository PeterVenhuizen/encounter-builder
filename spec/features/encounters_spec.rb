require 'rails_helper'

RSpec.describe 'Encounters', type: :feature, js: true do
  fixtures :monsters, :parties, :players

  let(:encounter_attributes) do
    {
      name: 'Two bandits',
      description: 'Two bandits and a cat',
      fates_attributes: [
        { monster_id: monsters(:bandit).id, group_size: 2 },
        { monster_id: monsters(:cat).id }
      ]
    }
  end

  before(:each) do
    party = parties(:party_of_three)
    @encounter = party.encounters.create(encounter_attributes)
  end

  scenario 'has button to start and resume encounter' do
    # create and start combat tracker
    visit encounter_path @encounter
    expect(page).to have_selector(:link_or_button, 'Start Encounter')
    click_on 'Start Encounter'
    expect(page).to have_css '.alert-success'

    # resume
    visit encounter_path @encounter
    expect(page).to have_selector(:link_or_button, 'Resume Encounter')
    expect {
      click_on 'Resume Encounter'
    }.to_not change(CombatTracker, :count)
    expect(page).to have_text 'Combat Tracker'
  end
end
