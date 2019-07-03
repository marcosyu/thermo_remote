class Api::V1::ReadingController < ApplicationController

  def create
    thermostat = Thermostat.find_by(household_token: params[:household_token])
    params_with_tracking_number = add_tracking_number(params[:household_token], reading_params )

    reading = Reading.new(params_with_tracking_number)

    if reading.valid?
      Resque.enqueue(ReadingJob, {token: params[:household_token], reading: params_with_tracking_number})

      render :json => ReadingSerializer.new(reading).serialized_json
    else
      render :json => {:errors => reading.errors.messages }
    end
  end

  def show
    cache = ActiveSupport::Cache::MemoryStore.new
    reading = cache.read(params[:household_token])

    if reading.blank?
      reading = Reading.joins(:thermostat).where(thermostats: {household_token: params[:household_token]}, tracking_number: params[:tracking_number]).take()
    end

    if reading.present?
      render json: ReadingSerializer.new(reading).serialized_json
    else
      render :json => {:errors => "Reading not found for household_token #{params[:household_token]} and #{params[:transaction_number]}" }
    end
  end

  private

  def add_tracking_number(token, reading)
    cache = ActiveSupport::Cache::MemoryStore.new
    last_number = cache.read(token).try("tracking_number") || 0
    reading[:tracking_number] = last_number + 1
    cache.write(token, reading)
    return reading
  end

  def reading_params
    params.require(:reading).permit(:thermostat_id, :temperature, :humidity, :battery_charge)
  end

end
