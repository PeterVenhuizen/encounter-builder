class AddDetailsToMonsters < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'hstore'
    add_column :monsters, :alignment, :string
    add_column :monsters, :hit_dice, :string
    add_column :monsters, :ability_scores, :hstore, default: { strength: 10, dexterity: 10, constitution: 10, intelligence: 10, wisdom: 10, charisma: 10 }
    add_column :monsters, :xp, :integer
    add_column :monsters, :proficiency_bonus, :integer, default: 2
  end
end
