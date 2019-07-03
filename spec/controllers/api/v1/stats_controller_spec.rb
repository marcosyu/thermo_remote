require 'rails_helper'

RSpec.describe Api::V1::StatsController, type: :controller do
  describe "get stats for thermostat" do

    let (:params){
      {
        household_token: "A1B2C3D4E5"
      }
    }

    it "returns reading for thermostat" do

      get :index, params: params do
        # expect(response.body).to match_response_schema("reading")
        expect(status).to eq(200)
      end

    end
  end
end
