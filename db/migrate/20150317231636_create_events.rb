class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :summary
      t.string :description
      t.string :location
      t.datetime :start
      t.datetime :end
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :events, :users
  end
end
