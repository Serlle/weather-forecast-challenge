class WeatherForecastsController < ApplicationController
  before_action :validate_cities_present, only: :index
  before_action :fetch_coordinates, only: :index

  def index
    if @coordinates.any? { |result| result.key?(:error) }
      flash[:error] = "Hubo un problema al obtener las coordenadas de la ciudad. Por favor intenta de nuevo más tarde."
      redirect_to new_weather_forecast_path
    else
      weather_service = OpenWeatherService.new
      @forecasts = weather_service.get_forecasts(@coordinates)
      flash[:success] = "Coordenadas obtenidas exitosamente"
    end
  end

  def new
  end

  private

  def cities_params
    params.permit(:cities, :commit)
  end

  def validate_cities_present
    @cities = cities_params[:cities].split(',').map(&:strip)
    if @cities.empty?
      flash[:error] = "No se proporcionaron ciudades. Por favor ingresa al menos una ciudad."
      render :new
    end
  end

  def fetch_coordinates
    service = ReservamosService.new
    @coordinates = @cities.map { |city| service.get_coordinates(city) }
  end
end
