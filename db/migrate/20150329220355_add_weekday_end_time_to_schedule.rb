class AddWeekdayEndTimeToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :weekday_end_time, :time
  end
end
