class Thermostat < ApplicationRecord
  has_many :readings

  validates :household_token, uniqueness: true, presence: true

end
