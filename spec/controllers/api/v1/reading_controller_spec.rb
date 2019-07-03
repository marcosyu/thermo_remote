require 'rails_helper'

RSpec.describe Api::V1::ReadingController, type: :controller do
  include ActiveJob::TestHelper
  after do
    clear_enqueued_jobs
  end

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
