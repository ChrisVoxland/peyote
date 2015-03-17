class CreateAuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.string :access_token
      t.string :refresh_token
      t.datetime :expires_at
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :auth_tokens, :users
  end
end
