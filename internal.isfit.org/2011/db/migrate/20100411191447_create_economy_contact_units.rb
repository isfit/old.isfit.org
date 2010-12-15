class CreateEconomyContactUnits < ActiveRecord::Migration
  def self.up
    create_table :economy_contact_units do |t|
      t.string :name
      t.text :address
      t.integer :zipcode
      t.string :city
      t.string :country
      t.integer :phone
      t.string :email
      t.string :homepage
      t.belongs_to :person
      t.belongs_to :unit_type

      t.timestamps
    end
  end

  def self.down
    drop_table :economy_contact_units
  end
end
