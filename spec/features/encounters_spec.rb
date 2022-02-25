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

  scenario 'has button to start and continue encounter' do
    # unplayed encounter
    visit encounters_path @encounter
    expect(page).to have_selector(:link_or_button, 'Start Encounter')
    click_on 'Start Encounter'

    # encounter already started
    visit encounters_path @encounter
    expect(page).to have_selector(:link_or_button, 'Continue Encounter')
    click_on 'Continue Encounter'
    expect(response).to render_template 'combat_trackers/show'
  end
end
