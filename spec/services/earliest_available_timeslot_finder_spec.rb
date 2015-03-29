require 'rails_helper'

describe EarliestAvailableTimeslotFinder do
  
  describe "#run" do
    let(:user) { create(:user) }
    let(:event) do
      create(
        :event,
        start_time: start_time,
        end_time: end_time,
        user: user
      )
    end
    let(:schedule) { create(:schedule, user: user) }
    let(:minutes_required) { 60 }
    let(:start_time) { Date.today + 18.hours }
    let(:end_time) { Date.today + 19.hours }
    
    subject (:service) do
      EarliestAvailableTimeslotFinder.new(user, date, minutes_required)
    end

    it "returns a start_time and end_time for the earliest free timeslot in the user's calendar" do
      expect(service.run.start_time).to eq(Date.today + 19.hours)
      expect(service.run.end_time).to eq(Date.today + 20.hours)
    end
  end
end
