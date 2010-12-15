class CreateEconomyContactPeople < ActiveRecord::Migration
  def self.up
    create_table :economy_contact_people do |t|
      t.string :title
      t.string :firstname
      t.string :lastname
      t.integer :phone1
      t.integer :phone2
      t.string :email
      t.text :comment
      t.belongs_to :unit

      t.timestamps
    end
  end

  def self.down
    drop_table :economy_contact_people
  end
end
