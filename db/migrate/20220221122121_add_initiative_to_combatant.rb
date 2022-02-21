class AddInitiativeToCombatant < ActiveRecord::Migration[6.1]
  def change
    add_column :combatants, :initiative, :integer, default: 0
  end
end
