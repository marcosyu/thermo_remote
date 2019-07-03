class Api::V1::StatsController < ApplicationController
  def index
    stats = ReadingQueryService.new().call

    if stats.present?
      render json: StatSerializer.new(stat).serialized_json
    else
      render json: {error: "No reading for thermostat"}

    end
  end
end
