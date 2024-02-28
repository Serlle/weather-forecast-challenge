class OpenWeatherService
  BASE_URL = 'https://api.openweathermap.org/data/2.5/forecast'

  def get_forecasts(coordinates)
    forecasts = []
    error = nil
    coordinates.each do |coord| 
      forecast = fetch_forecast(coord[:latitude], coord[:longitude])
      if forecast.key?(:body_error)
        error = forecast[:body_error]
        break
      end
      forecasts << forecast
    end

    if error
      { body_error: error }
    else
      { cities: forecasts }
    end
  end

  private

  def fetch_forecast(latitude, longitude)
    api_key = ENV['OPEN_WEATHER_MAP_API_KEY']
    city_paramater = { lat: latitude, lon: longitude, appid: api_key }
    response = Faraday.get(BASE_URL, city_paramater)
    parse_response(response)
  end

  def parse_response(response)
    weather_data = JSON.parse(response.body)
    check_status(weather_data)
  end

  def check_status(weather_data)
    if weather_data["cod"] == "200"
      forecast_list = weather_data["list"].map do |forecast| 
        { 
          date_time: forecast["dt_txt"], 
          temp_min: forecast["main"]["temp_min"],
          temp_max: forecast["main"]["temp_max"]
        } 
      end
      { 
        city: weather_data["city"]["name"], 
        forecast_list: forecast_list 
      }
    else
      { body_error: weather_data }
    end
  end
end