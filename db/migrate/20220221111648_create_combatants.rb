class CreateCombatants < ActiveRecord::Migration[6.1]
  def change
    create_table :combatants, id: :uuid do |t|

      t.timestamps
    end
  end
end
