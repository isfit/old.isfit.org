class AddMailToAlumniReservation < ActiveRecord::Migration
  def self.up
    add_column :alumni_reservations, :mail, :string
  end

  def self.down
    remove_column :alumni_reservations, :mail
  end
end
