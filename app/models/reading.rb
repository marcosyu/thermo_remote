class Reading < ApplicationRecord
  belongs_to :thermostat
  validates_presence_of :temperature, :humidity, :battery_charge

  def scheduled_save
    # Reading.includes(:thermostat).find_by_household_token()
    # self.tracking_number = self.thermostat.household_token
    ReadingJob.perform_later(self)
  end
end
