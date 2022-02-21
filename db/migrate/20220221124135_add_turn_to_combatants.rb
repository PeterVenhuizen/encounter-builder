class AddTurnToCombatants < ActiveRecord::Migration[6.1]
  def change
    add_column :combatants, :turn, :boolean, default: false
  end
end
