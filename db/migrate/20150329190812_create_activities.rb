class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :display_name
      t.string :description
      t.integer :frequency_per_week
      t.integer :time_to_spend
      t.string :location
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :activities, :users
  end
end
