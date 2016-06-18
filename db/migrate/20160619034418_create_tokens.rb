class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :token
      t.integer :token_type
      t.belongs_to :user

      t.timestamps
    end
  end
end
