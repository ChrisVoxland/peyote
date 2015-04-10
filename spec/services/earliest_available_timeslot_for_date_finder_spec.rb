require 'rails_helper'

#TODO: how will this handle user prefs? prefer earlier/later?
describe EarliestAvailableTimeslotForDateFinder do

  describe "#run" do
    let(:user) { create(:user) }
    let!(:schedule) { create(:schedule, user: user) }
    let(:minutes_required) { 60 }
    let(:start_time) { Date.today + 18.hours }
    let(:end_time) { Date.today + 19.hours }

    subject (:response) do
      EarliestAvailableTimeslotForDateFinder.new(user, Date.today, minutes_required).run
    end

    context "when a user has no events on a day" do

      it "returns the earliest possible start_time for the day" do
        expect(response.start_time).to eq(start_time)
      end

      it "returns the correct end_time" do
        expect(response.end_time).to eq(end_time)
      end

      it "returns a successful response" do
        expect(response.success?).to eq(true)
      end

      describe "finding time slots in more complicated situations" do

        context "when there are multiple events and enough time between them for the new event" do

          it "returns the earliest possible correct start_time" do
          end

          it "returns the correct end_time" do

          end

          it "returns a successful response" do

          end
        end

        context "when there are multiple events but not enough time between them for the new event" do

          it "returns an unsuccessful response object" do
            #expect(response.success?).to eq(false)
          end
        end
      end
    end

    #TODO: Flesh this test out. should probably test more failure cases
    context "when the user does not have a sufficiently large time slot for the event on the date" do
      let!(:event) do
        create(
          :event,
          start_time: start_time,
          end_time: schedule.latest_available_time_for_date(Date.today),
          user: user
        )
      end

      it "returns an unsuccessful response object" do
        expect(response.success?).to eq(false)
      end
    end
  end
end
