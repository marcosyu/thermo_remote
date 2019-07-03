FactoryBot.define do
  factory :thermostat do

    location{ FFaker::Address.street_address }
    household_token{ SecureRandom.hex(7) }
  end
end
