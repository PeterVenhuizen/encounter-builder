require 'rails_helper'

RSpec.describe 'Combat Tracker', type: :feature, js: true do
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
    @combat_tracker = @encounter.create_combat_tracker
  end

  scenario 'is started' do
    # go to encounter
    visit encounters_path @encounter

    # click on play encounter
    expect {
      click_on 'Start Encounter'
    }.to change(Combatant, :count).by(1)

    # assert redirect_to combat_tracker show
    expect(response).to render_template 'combat_trackers/show'
    expect(page).to have_css '.alert-success'
    expect(page).to have_text 'Combat Tracker'
  end

  scenario 'initiative is set and turns are played'
    # go to combat_tracker show
    # post initiative
    # assert combatants ordered by initiative
    # assert turn goes back to one after five
    # assert round + 1
  scenario 'is continued'
  scenario 'is destroyed'
end
