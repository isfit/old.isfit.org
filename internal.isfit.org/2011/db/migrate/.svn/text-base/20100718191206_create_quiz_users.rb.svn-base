class CreateQuizUsers < ActiveRecord::Migration
  def self.up
    create_table :quiz_users do |t|
      t.integer :user_id
      t.references :quiz_question
      t.references :quiz
      t.integer :points
      t.integer :guesses

      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_users
  end
end
