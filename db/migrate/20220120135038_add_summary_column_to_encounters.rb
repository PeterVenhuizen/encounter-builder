class AddSummaryColumnToEncounters < ActiveRecord::Migration[6.0]
  def change
    add_column :encounters, :summary, :json, default: { 
      total_experience: '0', difficulty: 'none', number_of_players: '0', average_level: '0' }
  end
end
