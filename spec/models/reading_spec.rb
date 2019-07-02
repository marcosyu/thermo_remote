require 'rails_helper'

RSpec.describe Reading, type: :model do
  reading {described_class.new(thermostat_id: "1", tracking_number: 1, temperature: 12.0, humidity: 16.0, battery_charge: 90.0 )}
  reading {described_class.new(thermostat_id: "1", tracking_number: 1, temperature: 12, humidity: 16.0, battery_charge: 90.0 )}

  it "is valid with valid attributes" do
    expect(reading).to be_valid
  end

  it "is not valid without thermostat_id" do
    reading.thermostat_id = nil
    expect(reading).to_not be_valid
  end
  it "is not valid with an invalid thermostat_id" do
    thermostat = Thermostat.find(reading.thermostat_id)
    expect(thermostat).to_not be_instance_of(Thermostat)
  end

  it "is not valid without tracking number" do
    reading.tracking_number = nil
    expect(reading).to_not be_valid
  end

  it "is not valid without temperature" do
    reading.temperature = nil
    expect(reading).to_not be_valid
  end
  it "temperature must be float" do
    reading.temperature = 1
    expect(reading).to_not be_valid
  end
  it "is not valid without humidity" do
    reading.humidity = nil
    expect(reading).to_not be_valid
  end
  it "humidity must be float" do
    reading.humidity = 1
    expect(reading).to_not be_valid
  end
  it "is not valid without battery_charge" do
    reading.battery_charge = nil
    expect(reading).to_not be_valid
  end
  it "battery_charge must be float" do
    reading.battery_charge = 1
    expect(reading).to_not be_valid
  end
end
