class EventsController < ApplicationController
  def create
    if event = Event.create(create_params)
      Google::Calendar.new(current_user).create_event(event)
      flash[:notice] = "it worked"
    else
      flash[:notice] = "SOMETHING FUCKED BRO!!!"
    end
  end

  private

  def create_params
    params.require(:event).permit(
      [
        :summary,
        :description,
        :location,
        :start_time,
        :end_time
      ]
    )
  end
end
