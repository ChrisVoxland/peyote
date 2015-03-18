class EventsController < ApplicationController
  def create
    if event = Event.create(create_params)
      event.create_event_for_user(current_user)
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
