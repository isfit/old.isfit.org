class CreateQuizzes < ActiveRecord::Migration
  def self.up
    create_table :quizzes do |t|
      t.integer :owner_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :quizzes
  end
end
