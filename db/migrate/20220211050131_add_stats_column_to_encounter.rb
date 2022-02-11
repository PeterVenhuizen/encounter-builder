class AddStatsColumnToEncounter < ActiveRecord::Migration[6.1]
  def change
    add_column :encounters, :stats, :json, default: {}
  end
end
