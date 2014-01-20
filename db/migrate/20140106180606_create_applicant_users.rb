class CreateApplicantUsers < ActiveRecord::Migration
  def change
    create_table :applicant_users do |t|
      t.string :mail
      t.string :password_digest

      t.timestamps
    end
  end
end
