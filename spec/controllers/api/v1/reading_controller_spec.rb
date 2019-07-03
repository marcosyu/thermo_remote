require 'rails_helper'
require 'logger'
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
  after(:all) do
    Resque.remove_schedule('save_reading')
  end

  describe "post call for reading" do

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

    let(:thermostat){ FactoryBot.create(:thermostat) }

    it "creates reading and return value" do
      post :create, params: params do
        expect(response_body).to match_response_schema("reading")
        expect(status).to eq(200)
      end
    end

    it "is invalid with no household_token" do
      params[:household_token] = nil

      post :create, params: params do
        expect(response_body).not_to match_response_schema("reading")
        Rails.logger = status
        expect(status).no_to eq(200)
      end

    end
  end


  # describe "get call for reading" do

  #   let (:params){
  #     {
  #       household_token: "A1B2C3D4E5",
  #       tracking_number: 20
  #     }
  #   }

  #   it "returns reading for thermostat" do

  #     get :show, params: params do
  #       expect(response.body).to match_response_schema("reading")
  #       expect(status).to eq(1)
  #     end

  #   end
  # end
end
