class WeatherForecastsController < ApplicationController
  before_action :redirect_to_new, only: :index
  before_action :validate_cities_present, only: :index

  def index
    weather_forecasts_service = WeatherForecastService.new
    info = weather_forecasts_service.get_forecasts(@cities)
    if info.include?(:body_error)
      flash[:error] = "#{info[:body_error]}"
      redirect_to new_weather_forecast_path
    else
      flash[:success] = "Coordenadas obtenidas exitosamente"
      @forecasts = info
    end
  end

  def new
  end

  private

  def cities_params
    params.permit(:cities, :commit)
  end

  def validate_cities_present
    @cities = cities_params[:cities]&.split(',')&.map(&:strip)
    if @cities.nil? || @cities.empty?
      flash[:error] = "No se proporcionaron ciudades. Por favor ingresa al menos una ciudad."
      redirect_to new_weather_forecast_path
    end
  end

  def redirect_to_new
    flash[:alert] = "Puedes entrar a index o al path de -weather_forecasts/- si solo ingresas los nombres de las ciudades"
    redirect_to new_weather_forecast_path if params[:cities].nil?
  end
end
