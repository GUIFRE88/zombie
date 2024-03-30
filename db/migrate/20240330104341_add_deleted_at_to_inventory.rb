class AddDeletedAtToInventory < ActiveRecord::Migration[7.1]
  def change
    add_column :inventories, :deleted_at, :datetime
    add_index :inventories, :deleted_at
  end
end
