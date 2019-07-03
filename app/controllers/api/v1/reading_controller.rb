class Api::V1::ReadingController < ApplicationController

  def create
    thermostat = Thermostat.find_by(household_token: params[:household_token])
    reading = Reading.new(reading_params.merge({thermostat_id: thermostat.try(:id)}))

    if reading.schedule_save
      render :json => reading
    else
      render :json => {:errors => reading.errors.messages }
    end
  end

  def show

    reading = Reading.joins(:thermostat).where(thermostats: {household_token: params[:household_token]}, tracking_number: params[:tracking_number]).first
    if reading.blank? && Resque.schedule.count > 0
      thermostat = Thermostat.find_by(household_token: params[:household_token])
      reading = Resque.schedule["save_reading"]["args"].select{|record| record["tracking_number"] == params[:household_token] && record["thermostat_id"] == params[:thermostat_id]}.first
    end
    if reading.present?
      render :json => reading
    else
      render :json => {:errors => "Reading not found for household_token #{params[:household_token]} and #{params[:transaction_number]}" }
    end
  end

  private

  def reading_params
    params.require(:reading).permit(:thermostat_id, :temperature, :humidity, :battery_charge)
  end

end
