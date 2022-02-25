class CreateCombatTrackers < ActiveRecord::Migration[6.1]
  def change
    create_table :combat_trackers, id: :uuid do |t|
      t.belongs_to :encounter, type: :uuid
      t.integer :round, default: 1
      t.integer :turn, default: 1
      
      t.timestamps
    end
  end
end
