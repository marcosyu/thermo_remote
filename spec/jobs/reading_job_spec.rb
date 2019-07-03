require "rails_helper"

RSpec.describe ReadingJob, :type => :job do
  describe "performs" do
    include ActiveJob::TestHelper

    after do
      clear_enqueued_jobs
    end

    let(:thermostat){ FactoryBot.create(:thermostat) }
    let (:params){
      {
        household_token: SecureRandom.hex(7),
        reading:{
          tracking_number: rand(20.0),
          thermostat_id: thermostat.id,
          temperature: rand(20.0),
          humidity: rand(20.0),
          battery_charge: rand(20.0)
        }
      }
    }

    it "schedule_save for reading" do
      ReadingJob.perform(token: params[:household_token], params: params[:reading])

      reading = Reading.last
      expect(reading.tracking_number).to eq params[:reading][:tracking_number]
      expect(reading.temperature).to eq params[:reading][:temperature]
      expect(reading.humidity).to eq params[:reading][:humidity]
      expect(reading.battery_charge).to eq params[:reading][:battery_charge]
      expect(reading.thermostat_id).to eq params[:reading][:thermostat_id]
    end
  end
end
