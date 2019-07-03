require 'rails_helper'

RSpec.describe Api::V1::ReadingController, type: :controller do

  # 1. POST Reading: collects temperature, humidity and battery charge from a particular thermostat.
  # This method is going to have a very high request rate because many IoT thermostats are going to call
  # it very frequently and simultaneously. Make it as fast as possible and schedule a background job
  # for writing to the DB (you can use Sidekiq for example). The method also returns a generated tracking
  # number starting from 1 and every household has its own tracking sequence.

  # 2. GET Reading: returns the thermostat reading data by the tracking number obtained from POST
  # Reading. The API must be consistent, that is if the method 1 returns, the thermostat data must be
  # immediately available from this method even if the background job is not yet finished.

  # Reading:
  # ● id (primary key)
  # ● thermostat_id (foreign key)
  # ● tracking_number (integer)
  # ● temperature (float)
  # ● humidity (float)
  # ● battery_charge (float)

  describe "post call for reading" do

    let(:thermostat){ FactoryBot.create(:thermostat) }

    let (:params){
      {
        household_token: SecureRandom.hex(7),
        reading:{
          thermostat_id: thermostat.id,
          temperature: rand(20.0),
          humidity: rand(20.0),
          battery_charge: rand(20.0)
        }
      }
    }


    it "creates reading and return value" do
      post :create, params: params

      content = JSON.parse(response.body)["data"]["attributes"]
      expect(content["tracking_number"]).to eq 1
      expect(content["temperature"].to_f).to eq params[:reading][:temperature]
      expect(content["humidity"].to_f).to eq params[:reading][:humidity]
      expect(content["battery_charge"].to_f).to eq params[:reading][:battery_charge]
    end

  end


  describe "get call for reading" do

    let(:reading){ FactoryBot.create(:reading) }

    let (:params){
      {
        household_token: reading.thermostat.household_token,
        tracking_number: reading.tracking_number
      }
    }

    it "returns reading for thermostat" do
      get :show, params: params

      content = JSON.parse(response.body)["data"]["attributes"]
      expect(content["tracking_number"]).to eq reading.tracking_number
      expect(content["temperature"].to_f).to eq reading.temperature
      expect(content["humidity"].to_f).to eq reading.humidity
      expect(content["battery_charge"].to_f).to eq reading.battery_charge

    end
  end
end
