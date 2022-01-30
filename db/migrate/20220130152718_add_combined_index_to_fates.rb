class AddCombinedIndexToFates < ActiveRecord::Migration[6.0]
  def change
    add_index :fates, [:encounter_id, :monster_id, :group_size], unique: true
  end
end
