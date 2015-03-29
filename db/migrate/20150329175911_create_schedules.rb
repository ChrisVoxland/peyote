class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.time :weekend_start_time
      t.time :weekend_end_time
      t.time :weekday_start_time
      t.time :weekday_start_time
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :schedules, :users
  end
end
