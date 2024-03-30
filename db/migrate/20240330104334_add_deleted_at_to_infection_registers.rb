class AddDeletedAtToInfectionRegisters < ActiveRecord::Migration[7.1]
  def change
    add_column :infection_registers, :deleted_at, :datetime
    add_index :infection_registers, :deleted_at
  end
end
