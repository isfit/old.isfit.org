class CreateHosts < ActiveRecord::Migration
  def self.up
    create_table :hosts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address
      t.integer :zipcode
      t.string :place
      t.integer :age
      t.boolean :before
      t.text :why
      t.string :where
      t.integer :number
      t.integer :skies
      t.boolean :arrival_before
      t.boolean :leave_late
      t.text :preference
      t.string :pet
      t.text :know_isfit
      t.string :member_name

      t.timestamps
    end
  end

  def self.down
    drop_table :hosts
  end
end
