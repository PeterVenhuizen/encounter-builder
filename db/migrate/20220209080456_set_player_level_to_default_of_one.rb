class SetPlayerLevelToDefaultOfOne < ActiveRecord::Migration[6.1]
  def change
    change_column :players, :level, :integer, default: 1
  end
end
