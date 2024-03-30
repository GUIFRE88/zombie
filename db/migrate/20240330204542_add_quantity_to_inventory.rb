class AddQuantityToInventory < ActiveRecord::Migration[7.1]
  def change
    add_column :inventories, :quantity, :integer, default: 0
  end
end
