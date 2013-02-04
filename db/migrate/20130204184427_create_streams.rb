class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :title
      t.datetime :publish_at
      t.datetime :start_at
      t.datetime :end_at
      t.string :embed_id

      t.timestamps
    end
  end
end
