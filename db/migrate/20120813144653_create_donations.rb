class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :status
      t.float :amount
      t.string :transaction_number
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
