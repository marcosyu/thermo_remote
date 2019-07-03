class Api::V1::StatsController < ApplicationController
  def index
    stats = StatQueryService.new().call

    if stats.present?
      render json: stats
    else
      render json: {error: "No reading for thermostat"}

    end
  end
end
