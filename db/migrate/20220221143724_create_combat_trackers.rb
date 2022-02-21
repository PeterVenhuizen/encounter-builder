class CreateCombatTrackers < ActiveRecord::Migration[6.1]
  def change
    create_table :combat_trackers, id: :uuid do |t|

      t.timestamps
    end
  end
end
