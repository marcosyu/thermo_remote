class Thermostat < ApplicationRecord
  has_many :readings

  validates :household_token, presence: true

end
