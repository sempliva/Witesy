class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :password
      t.string :salt
      t.boolean :confirmed_email, default: false
      t.datetime :last_login

      t.timestamps null: false
    end
  end
end
