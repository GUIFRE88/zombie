class CreateInventory < ActiveRecord::Migration[7.1]
  def change
    create_table :inventories do |t|
      t.references :user, foreign_key: true
      t.string :item
      t.integer :point
      t.boolean :block, default: false

      t.timestamps
    end
  end
end
