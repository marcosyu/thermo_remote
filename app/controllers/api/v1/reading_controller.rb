class Api::V1::ReadingController < ApplicationController

  def create
    reading = Reading.new(reading_params)
    byebug
    if reading.schedule_save
      render :json => reading
    else
      render :json => {:errors => reading.errors.messages }
    end
  end

  private

  def reading_params
    params.require(:reading).permit(:thermostat_id, :temperature, :humidity, :battery_charge)
  end

end
