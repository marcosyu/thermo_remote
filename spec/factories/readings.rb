FactoryBot.define do
  factory :reading do
    association(:thermostat)
    tracking_number {SecureRandom.random_number(0..100)}
    temperature {SecureRandom.random_number(0.0..100.0)}
    humidity {SecureRandom.random_number(0.0..100.0)}
    battery_charge {SecureRandom.random_number(0.0..100.0)}
  end
end
