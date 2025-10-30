class ForecastsController < ApplicationController
  def show
    @forecast = Forecast.for_address(params[:address])
  end
end
