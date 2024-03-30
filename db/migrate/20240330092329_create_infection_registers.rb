class CreateInfectionRegisters < ActiveRecord::Migration[7.1]
  def change
    create_table :infection_registers do |t|
      t.references :user, foreign_key: true
      t.integer :user_infect_id
      t.timestamps
    end
  end
end
