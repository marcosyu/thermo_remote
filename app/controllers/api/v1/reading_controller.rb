class Api::V1::ReadingController < ApplicationController
  def create
    if @reading.save
      render :json => @reading
    else
      render :json => {:errors => @reading.errors.messages }
    end
  end
end
