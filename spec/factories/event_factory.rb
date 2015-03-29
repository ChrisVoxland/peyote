FactoryGirl.define do

  factory :event do
    user
    start_time { Date.tomorrow + 12.hours }
    end_time { Date.tomorrow + 15.hours }
  end
end
