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

  it "creates reading and return value" do
    params = {
      reading:{
        thermostat_id: 1,
        temperature: 25.0,
        humidity: 5.0,
        battery_charge: 50.0
      }
    }
    expect(params[:reading]).to be_truthy
    expect(params[:reading]).not_to have_key(:tracking_number)

    expect(params[:reading]).to have_key(:thermostat_id)

    thermostat= Thermostat.find(params[:thermostat_id])

    if expect(params).to(have_key(:reading)) && thermostat.to(be_instance_of(Thermostat))
      expect(params[:reading][:humidity]).to be_kind_of(Float)
      expect(params[:reading][:temperature]).to be_kind_of(Float)
      expect(params[:reading][:battery_charge]).to be_kind_of(Float)
      post :create, params: params do
        example_request "with a body" do
          expect(response_body).to match_response_schema("reading")
          expect(status).to eq(200)
        end
      end
    end

  end


end
