FactoryGirl.define do

  factory :schedule do
    user
    weekday_start_time { Date.today + 18.hours } #6:00 pm
    weekday_end_time { Date.today + 22.hours } #10:00 pm
    weekend_start_time { Date.today + 18.hours } #6:00 pm
    weekend_end_time { Date.today + 22.hours } #10:00 pm
  end
end
