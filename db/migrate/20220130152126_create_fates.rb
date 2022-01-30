class CreateFates < ActiveRecord::Migration[6.0]
  def change
    create_table :fates, id: :uuid do |t|
      t.integer :group_size
      t.belongs_to :encounter, null: false, foreign_key: true, type: :uuid
      t.belongs_to :monster, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
