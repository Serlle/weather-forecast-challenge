class WeatherForecastsController < ApplicationController
  def index
  end

  def new
  end

  def create
    cities = cities_params[:cities].split(',').map(&:strip)
    service = ReservamosService.new
    @coordinates = cities.map { |city| service.get_coordinates(city) }
  end

  private

  def cities_params
    params.permit(:cities)
  end
end
