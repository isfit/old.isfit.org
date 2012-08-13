class CreateOauthUsers < ActiveRecord::Migration
  def change
    create_table :oauth_users do |t|
      t.string :token
      t.string :facebook_id
      t.string :name

      t.timestamps
    end
  end
end
