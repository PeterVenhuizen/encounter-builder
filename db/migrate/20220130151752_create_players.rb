class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players, id: :uuid do |t|
      t.string :name
      t.integer :level
      t.belongs_to :party, index: true, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
