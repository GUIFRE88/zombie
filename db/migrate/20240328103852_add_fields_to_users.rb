class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
