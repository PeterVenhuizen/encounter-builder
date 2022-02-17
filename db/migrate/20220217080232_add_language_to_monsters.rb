class AddLanguageToMonsters < ActiveRecord::Migration[6.1]
  def change
    add_column :monsters, :languages, :string
  end
end
