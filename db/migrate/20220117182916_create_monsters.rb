class CreateMonsters < ActiveRecord::Migration[6.0]
  def change
    create_table :monsters, id: :uuid do |t|
      t.string :name
      t.string :size
      t.string :type
      t.integer :armor_class
      t.string :hit_points
      t.string :challenge_rating

      t.timestamps
    end
  end
end
