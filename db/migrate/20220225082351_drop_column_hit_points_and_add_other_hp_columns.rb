class DropColumnHitPointsAndAddOtherHpColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :combatants, :hit_points, :integer, default: 0
    add_column :combatants, :max_hp, :integer, default: 1
    add_column :combatants, :current_hp, :integer, default: 1
  end
end
