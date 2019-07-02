require 'rails_helper'

RSpec.describe Thermostat, type: :model do
  thermostat  = described_class.new(location: "location1", household_token: "A1B2C3D4E5" )

  it "is valid with valid attributes" do
    expect(thermostat).to be_valid
  end

  it "is not valid without a household_token" do
    thermostat.household_token = nil
    expect(thermostat).to_not be_valid
  end
end
