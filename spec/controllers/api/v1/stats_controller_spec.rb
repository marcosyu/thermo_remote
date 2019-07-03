require 'rails_helper'

RSpec.describe Api::V1::StatsController, type: :controller do
  describe "get stats for thermostat" do
    5.times do |n|
      let("reading#{n}".to_sym){ FactoryBot.create(:reading) }
    end

    it "returns reading for thermostat" do

      byebug
      Reading.order(:temperature, 'desc' )

      get :index, params: params do
        # expect(response.body).to match_response_schema("reading")
        expect(status).to eq(200)
      end

    end
  end
end
