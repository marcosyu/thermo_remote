# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
thermostats = [
  { household_token: SecureRandom.hex(7), location: "1st St" },
  { household_token: SecureRandom.hex(7), location: "2nd St" },
  { household_token: SecureRandom.hex(7), location: "3rd St" }
]

thermostats.each do |thermostat|
  Thermostat.create(thermostat)
end
