class EncounterBelongsToParty < ActiveRecord::Migration[6.0]
  def change
    add_reference :encounters, :party, index: true, foreign_key: true, type: :uuid
  end
end
