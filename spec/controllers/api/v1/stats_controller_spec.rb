require 'rails_helper'
require "rspec-sqlimit"

RSpec.describe Api::V1::StatsController, type: :controller do
  describe "get stats for thermostat" do


    5.times do |n|
      let("reading#{n}".to_sym){ FactoryBot.create(:reading) }
    end

    let(:readings){ [reading0, reading1, reading2, reading3, reading4] }
    let (:params){
      {
        household_token: SecureRandom.hex(7)
      }
    }

    it "only sends 1 requests to db" do
      expect { StatQueryService.new().call }.not_to exceed_query_limit(1)
    end

    it "returns reading for thermostat" do
      by_temperature = readings.sort_by{|r| r.temperature.to_f.round(2) }
      by_humidity = readings.sort_by{|r| r.humidity.to_f.round(2) }
      by_battery_charge = readings.sort_by{|r| r.battery_charge.to_f.round(2) }

      get :index, params: params
      content = JSON.parse(response.body)[0]

      expect(content["avg_temperature"]).to eq Reading.average(:temperature).to_f.round(2)
      expect(content["min_temperature"]).to eq by_temperature.first.temperature.to_f.round(2)
      expect(content["max_temperature"]).to eq by_temperature.last.temperature.to_f.round(2)

      expect(content["avg_humidity"]).to eq Reading.average(:humidity).to_f.round(2)
      expect(content["min_humidity"]).to eq by_humidity.first.humidity.to_f.round(2)
      expect(content["max_humidity"]).to eq by_humidity.last.humidity.to_f.round(2)

      expect(content["avg_battery_charge"]).to eq Reading.average(:battery_charge).to_f.round(2)
      expect(content["min_battery_charge"]).to eq by_battery_charge.first.battery_charge.to_f.round(2)
      expect(content["max_battery_charge"]).to eq by_battery_charge.last.battery_charge.to_f.round(2)

    end
  end
end
