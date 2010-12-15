class CreateImfContactUnits < ActiveRecord::Migration
  def self.up
    create_table :imf_contact_units do |t|
      t.string :name
      t.text :address1
      t.text :address2
      t.integer :zipcode
      t.string :city
      t.belongs_to :country
      t.integer :phone1
      t.integer :phone2
      t.string :email
      t.integer :fax
      t.belongs_to :imf_contact_status
      t.belongs_to :functionary
      t.belongs_to :imf_contact_person

      t.timestamps
    end
  end

  def self.down
    drop_table :imf_contact_units
  end
end
