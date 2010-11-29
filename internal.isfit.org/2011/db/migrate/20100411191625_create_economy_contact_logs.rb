class CreateEconomyContactLogs < ActiveRecord::Migration
  def self.up
    create_table :economy_contact_logs do |t|
      t.integer :festival_no
      t.text :body
      t.text :advice
      t.string :author
      t.belongs_to :unit

      t.timestamps
    end
  end

  def self.down
    drop_table :economy_contact_logs
  end
end
