require "test_helper"

class WeatherForecastsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_weather_forecast_url
    assert_response :success
  end

  test "should get coordinates for cities" do
    service = WeatherForecastService.new
    params = "CDMX, Colima, Guadalajara, MTY"
    cities = params.split(',').map(&:strip)

    result = service.get_forecasts(cities)

    coordinates = result[1][:coordinates]
    assert_not_nil coordinates
    assert_equal 4, coordinates.count

    coordinates.each do |coordinate|
      assert_not_nil coordinate[:latitude]
      assert_not_nil coordinate[:longitude]
    end
  end

  test "should redirect with error message when cities parameter is blank" do
    get weather_forecasts_url, params: { cities: "" }
    assert_not_nil flash[:error]
    assert_equal "No se proporcionaron ciudades. Por favor ingresa al menos una ciudad.", flash[:error]
  end

  test "should redirect a error message when the API of coordinates fails" do
    mock_service = Minitest::Mock.new
    def mock_service.get_coordinates(city)
      { body_error: "Hubo un problema con conectar a la api de Reservamos" }
    end
  
    ReservamosService.stub :new, mock_service do
      get weather_forecasts_url, params: { cities: "CDMX" }
      
      assert_not_nil flash[:error]
      assert_redirected_to new_weather_forecast_path

      assert_equal "Hubo un problema con conectar a la api de Reservamos", flash[:error]
    end
  end

  test "should redirect a error message when the API of Open Weather fails" do
    mock_service = Minitest::Mock.new
    def mock_service.get_forecasts(cities)
      { body_error: "Hubo un problema con conectar a la api de Open Weather" }
    end
  
    WeatherForecastService.stub :new, mock_service do
      get weather_forecasts_url, params: { cities: "CDMX" }
      
      assert_not_nil flash[:error]
      assert_redirected_to new_weather_forecast_path

      assert_equal "Hubo un problema con conectar a la api de Open Weather", flash[:error]
    end
  end

  test "should get tempertures of cities with coordinates" do
    get weather_forecasts_url, params: { cities: "Cancun, MTY" }
    forecasts = assigns(:forecasts)

    assert_not_nil forecasts[0][:cities]
    assert_equal 2, forecasts[0][:cities].count

    forecasts[0][:cities].each do |forecast|
      assert_not_nil forecast[:forecast_list][0][:temp_min]
      assert_not_nil forecast[:forecast_list][0][:temp_max]
    end
  end
end
