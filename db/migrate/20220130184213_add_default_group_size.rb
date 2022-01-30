class AddDefaultGroupSize < ActiveRecord::Migration[6.0]
  def change
    change_column :fates, :group_size, :integer, default: 1
  end
end
