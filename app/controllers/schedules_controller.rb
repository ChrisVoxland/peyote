class SchedulesController < ApplicationController

  def create
    if current_user.schedule
      current_user.schedule.update_attributes(schedule_params)
    else
      current_user.create_schedule(schedule_params)
    end
  end

  private

  def schedule_params
    params.permit(
      :weekday_start_time,
      :weekday_end_time,
      :weekend_start_time,
      :weekend_end_time
    )
  end
end
