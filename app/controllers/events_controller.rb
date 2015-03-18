class EventsController < ApplicationController
  def create
    
  end

  private

  def create_params
    params.permit(
      :summary,
      :description,
      :location,
      :start,
      :end
    )
  end
end
