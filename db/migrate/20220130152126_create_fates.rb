class CreateFates < ActiveRecord::Migration[6.0]
  def change
    create_table :fates, id: :uuid do |t|
      t.references :encounter, null: false, foreign_key: true
      t.references :monster, null: false, foreign_key: true

      t.timestamps
    end
  end
end
