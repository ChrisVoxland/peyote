class Activity < ActiveRecord::Base
  belongs_to :user

  #TODO: How do I want to handle distributing events? User preference probably? Maybe have a #of activities per day setting on Schedule model?

end
