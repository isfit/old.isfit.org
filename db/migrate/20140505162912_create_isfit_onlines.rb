class CreateIsfitOnlines < ActiveRecord::Migration
  def change
    create_table :isfit_onlines do |t|
      t.text :embed_code

      t.timestamps
    end
  end
end
