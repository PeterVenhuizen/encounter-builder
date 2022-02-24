class CreateCombatants < ActiveRecord::Migration[6.1]
  def change
    create_table :combatants, id: :uuid do |t|
      t.integer :initiative, default: 0
      t.boolean :turn, default: false
      t.integer :hit_points, default: 0
      t.references :combatable, type: :uuid, polymorphic: true
      t.timestamps
    end
    add_reference :combatants, :combat_tracker, null: false, foreign_key: true, type: :uuid
  end
end
