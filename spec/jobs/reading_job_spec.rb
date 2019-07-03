require "rails_helper"

RSpec.describe ReadingJob, :type => :job do
  describe "performs" do
    include ActiveJob::TestHelper

    after do
      Resque.remove_schedule('save_reading')
    end

    let (:params){
      {
        household_token: "A1B2C3D4E5",
        reading:{
          thermostat_id: 1,
          temperature: 25.0,
          humidity: 5.0,
          battery_charge: 50.0
        }
      }
    }

    it "schedule_save for reading" do
      ActiveJob::Base.queue_adapter = :test
      reading= Reading.new(params[:reading])
      reading.schedule_save

      expect(Resque.schedule.count).to equal(1)
    end
  end
end
