class Api::V1::StatsController < ApplicationController
  def index
    thermostat = Thermostat.find_by(household_token: params[:household_token])
    readings = thermostat.readings.to_a

    if Resque.schedule.present?
      cache_readings = Resque.schedule["save_reading"]["args"].select{|s| s.thermostat_id == thermostat.id}
      readings << cache_readings
    end

    stats = ActiveRecord::Base.connection.execute("
    	SELECT MIN(temperature), MAX(temperature), AVG(humidity), AVG(cattery_charge)
    	FROM INNER JOIN thermostats ON thermostats.id = readings.thermostat_id WHERE thermostats.household_token = #{params[:household_token]}")
    # find_by_sql
    if stats.present?
      render json: stats
    else
      render json: {error: "No reading for thermostat"}

    end
  end
end
