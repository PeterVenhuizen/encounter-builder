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
    # @combat_tracker = @encounter.create_combat_tracker
  end

  scenario 'is started' do
    # go to encounter
    visit encounter_path @encounter

    # click on play encounter
    expect {
      click_on 'Start Encounter'
    }.to change(CombatTracker, :count).by(1)

    expect(page).to have_css '.alert-success'
    expect(page).to have_text 'Combat Tracker'
    expect(page).to have_text 'Description'
  end

  scenario 'initiative is set and turns are played'
    # go to combat_tracker show
    # visit combat_tracker_path @combat_tracker
    
    # post initiative
    # combatants = @combat_tracker.combatants
    # @combat_tracker.update(
    #                         combatants_attributes:
    #                           [
    #                             { id: combatants.first.id, initiative: 5 },
    #                             { id: combatants.second.id, initiative: 13 },
    #                             { id: combatants.third.id, initiative: 21 },
    #                             { id: combatants.fourth.id, initiative: 14 },
    #                             { id: combatants.fifth.id, initiative: 8 },
    #                             { id: combatants.last.id, initiative: 17 }
    #                           ] )

    # assert combatants ordered by initiative
    # combatants = assigns(:combat_tracker).combatants
    # expect(combatants.first.initiative).to eq 21
    # expect(combatants.last.initiative).to eq 5

    # assert turn goes back to one after five
    # assert round + 1

  scenario 'is continued'
  scenario 'is destroyed'
end
