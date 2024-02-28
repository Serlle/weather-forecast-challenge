class WeatherForecastsController < ApplicationController
  def index
  end

  def new
  end

  def create
    cities = cities_params[:cities].split(',').map(&:strip)
    if cities.empty?
      flash[:error] = "No se proporcionaron ciudades. Por favor ingresa al menos una ciudad."
      render :new
      return
    end

    service = ReservamosService.new
    @coordinates = cities.map { |city| service.get_coordinates(city) }

    if @coordinates.any? { |result| result.key?(:error) }
      flash[:error] = "Hubo un problema al obtener las coordenadas de la ciudad. Por favor intenta de nuevo más tarde."
      render :new
    else
      flash[:success] = "Cordenadas obtenidas exitosamente"
      redirect_to weather_forecasts_path
    end
  end

  private

  def cities_params
    params.permit(:cities)
  end
end
