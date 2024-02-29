class WeatherForecastService
  def get_forecasts(cities)
    coordinates = fetch_coordinates(cities)

    if coordinates.any? { |result| result.key?(:body_error) } 
      return { body_error: coordinates[0][:body_error] }
    end

    forecasts = fetch_forecast(@coordinates)

    if forecasts.include?(:body_error)
      return { body_error: "Hubo un problema con conectar a la api de Open Weather" }
    else
      return [ forecasts, { coordinates: coordinates } ]
    end
  end

  private

  def fetch_coordinates(cities)
    service = ReservamosService.new
    @coordinates = cities.map { |city| service.get_coordinates(city) }
  end

  def fetch_forecast(coordinates)
    open_weather_service = OpenWeatherService.new
    @forecasts = open_weather_service.get_forecasts(coordinates)
  end
end