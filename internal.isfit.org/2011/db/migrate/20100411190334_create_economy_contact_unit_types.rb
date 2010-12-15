class CreateEconomyContactUnitTypes < ActiveRecord::Migration
  def self.up
    create_table :economy_contact_unit_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :economy_contact_unit_types
  end
end
