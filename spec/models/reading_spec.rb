require 'rails_helper'

RSpec.describe Reading, type: :model do
  # reading = described_class.new(thermostat_id: "1", tracking_number: 1, temperature: 12.0, humidity: 16.0, battery_charge: 90.0 )

  thermostat = Thermostat.create!(location: "loc1", household_token: "A1B2C3D4E5")
  reading = thermostat.readings.new(thermostat_id: 1, tracking_number: 1, temperature: 12, humidity: 16.0, battery_charge: 90.0 )

  it "is valid with valid attributes" do

    expect(reading).to be_valid
  end

  it "is not valid without temperature" do
    reading.temperature = nil
    expect(reading).to_not be_valid
  end

  it "is not valid without humidity" do
    reading.humidity = nil
    expect(reading).to_not be_valid
  end

  it "is not valid without battery_charge" do
    reading.battery_charge = nil
    expect(reading).to_not be_valid
  end

end
