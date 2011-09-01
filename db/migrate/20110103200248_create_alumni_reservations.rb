class CreateAlumniReservations < ActiveRecord::Migration
  def self.up
    create_table :alumni_reservations do |t|
      t.string :firstname
      t.string :surname
      t.integer :isfit_year
      t.integer :phone
      t.boolean :restaurant
      t.boolean :peaceprize_ceremony
      t.boolean :hybel_friday
      t.boolean :hybel_saturday

      t.timestamps
    end
  end

  def self.down
    drop_table :alumni_reservations
  end
end
