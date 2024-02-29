class ReservamosService
  BASE_URL = 'https://search.reservamos.mx/api/v2/places'

  def get_coordinates(city)
    response = fetch_data(city)
    parse_response(response)
  end

  private

  def fetch_data(city)
    city_paramater = { q: city }
    Faraday.get(BASE_URL, city_paramater)
  end

  def parse_response(response)
    data = JSON.parse(response.body)
    result_type(data)
  end

  def result_type(data)
    data = data[0]

    if data["result_type"] == "city"
      { latitude: data["lat"], longitude: data["long"] }
    else
      { body_error: "Hubo un problema con conectar a la api de Reservamos" }
    end
  end
end
