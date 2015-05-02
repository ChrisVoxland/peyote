require 'rails_helper'

describe EarliestAvailableTimeslotForDateFinder do

  describe "#run" do
    let(:user) { create(:user) }
    let!(:schedule) { create(:schedule, user: user) }
    let(:minutes_required) { 60 }
    let(:expected_start_time) { Date.today + 18.hours }
    let(:expected_end_time) { Date.today + 19.hours }

    subject (:response) do
      EarliestAvailableTimeslotForDateFinder.new(user, Date.today, minutes_required).run
    end

    context "when a user has no events on a day" do

      it "returns the earliest possible start_time for the day" do
        expect(response.start_time).to eq(expected_start_time)
      end

      it "returns the correct end_time" do
        expect(response.end_time).to eq(expected_end_time)
      end

      it "returns a successful response" do
        expect(response.success?).to eq(true)
      end

      describe "finding time slots when there are events on a day" do

        context "when there are multiple events and enough time between them for the new event" do
          let!(:event_2) do
            create(
              :event,
              user: user,
              start_time: Date.today + 18.hours,
              end_time: Date.today + 18.hours + 30.minutes
            )
          end
          let!(:event_2) do
            create(
              :event,
              user: user,
              start_time: Date.today + 18.hours + 30.minutes,
              end_time: Date.today + 20.hours
            )
          end
          let!(:event_3) do
            create(
              :event,
              user: user,
              start_time: Date.today + 21.hours,
              end_time: Date.today + 22.hours
            )
          end
          let!(:event_4) do
            create(
              :event,
              user: user,
              start_time: Date.today + 23.hours,
              end_time: Date.tomorrow
            )
          end
          let(:expected_start_time) { Date.today + 20.hours }
          let(:expected_end_time) { Date.today + 21.hours }

          it "returns the earliest possible correct start_time" do
            expect(response.start_time).to eq(expected_start_time)
          end

          it "returns the correct end_time" do
            expect(response.end_time).to eq(expected_end_time)
          end

          it "returns a successful response" do
            expect(response.success?).to eq(true)
          end
        end

        context "when there are multiple events but not enough time between them for the new event" do
          let!(:event_1) do
            create(
              :event,
              user: user,
              start_time: Date.today + 18.hours,
              end_time: Date.today + 20.hours + 30.minutes
            )
          end
          let!(:event_2) do
            create(
              :event,
              user: user,
              start_time: Date.today + 21.hours,
              end_time: Date.today + 22.hours
            )
          end

          it "returns an unsuccessful response object" do
            expect(response.success?).to eq(false)
          end
        end
      end
    end

    context "when the user does not have a sufficiently large time slot for the event on the date" do
      let!(:event) do
        create(
          :event,
          start_time: schedule.earliest_available_time_for_date(Date.today),
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
