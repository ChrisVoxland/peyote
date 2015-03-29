class ActivitiesController < ApplicationController
  def create
    current_user.activities.create(create_params)
  end

  private

  def create_params
    params.require(:activity).permit(
      :display_name,
      :description,
      :location,
      :frequency_per_week,
      :time_to_spend
    )
  end
end
