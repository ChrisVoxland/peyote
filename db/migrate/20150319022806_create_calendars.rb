class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :calendar_id
      t.string :summary
      t.string :access_role
      t.boolean :primary
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :calendars, :users
  end
end
