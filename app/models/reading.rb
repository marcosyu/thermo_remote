class Reading < ApplicationRecord
  belongs_to :thermostat
  validates_presence_of :temperature, :humidity, :battery_charge

  def schedule_save
    Resque.set_schedule('save_reading', job_config(self))
  end

  private

  def job_config(reading)
    readings = Resque.schedule["save_reading"].present? ? Resque.schedule["save_reading"]["args"] : []
    last_number = 0

    if readings.present?
      last_number = Resque.schedule["save_reading"]["args"].last["tracking_number"]
    else
      last_number ||= Reading.where(thermostat_id: reading.thermostat_id).order(tracking_number: :desc).first.tracking_number
    end
    reading.tracking_number = last_number + 1

    config = { class: 'ReadingJob', every: ['1d', {first_in: 1.minute}], persist: true }
    readings << reading
    return config.merge({args: readings})
  end

end
