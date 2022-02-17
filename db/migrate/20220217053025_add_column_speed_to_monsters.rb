class AddColumnSpeedToMonsters < ActiveRecord::Migration[6.1]
  def change
    add_column :monsters, :speed, :hstore, default: { walk: 0, burrow: 0, climb: 0, fly: 0, swim: 0 }
  end
end
