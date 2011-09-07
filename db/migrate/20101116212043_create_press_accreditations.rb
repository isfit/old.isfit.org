class CreatePressAccreditations < ActiveRecord::Migration
  def self.up
    create_table :press_accreditations do |t|
      t.string :organization
      t.string :firstname
      t.string :surname
      t.string :function
      t.string :day_period
      t.boolean :access_whole_festival
      t.string :email
      t.string :phone
      t.string :birth
      t.text :remarks

      t.timestamps
    end
  end

  def self.down
    drop_table :press_accreditations
  end
end
