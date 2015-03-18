class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.string :password_hash
      t.string :password_salt

      t.string :verification_digest
      t.boolean :email_verification
      t.datetime :verified_at

      t.string :api_authtoken
      t.datetime :authtoken_expiry

      t.string :provider
      t.string :uid

      t.boolean :admin

      t.string :remember_digest

      t.string :reset_digest
      t.datetime :reset_sent_at

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :uid, unique: true
  end
end
