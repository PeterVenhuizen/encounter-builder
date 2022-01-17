class ChangeMonsterTypeColumnNameToSpecies < ActiveRecord::Migration[6.0]
  def change
    rename_column :monsters, :type, :species
  end
end
