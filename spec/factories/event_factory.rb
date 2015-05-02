FactoryGirl.define do

  factory :event do
    user
    start_time { Date.today + 12.hours }
    end_time { Date.today + 15.hours }
  end
end
