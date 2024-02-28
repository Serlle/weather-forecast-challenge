require "test_helper"

class WeatherForecastsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get weather_forecasts_url
    assert_response :success
  end

  test "should get new" do
    get new_weather_forecast_url
    assert_response :success
  end

  test "should get coordinates for cities" do
    post weather_forecasts_url, params: { cities: "CDMX, Colima, Guadalajara, MTY" }

    coordinates = assigns(:coordinates)
    assert_not_nil coordinates
    assert_equal 4, coordinates.length

    coordinates.each do |coordinate|
      assert_not_nil coordinate[:latitude]
      assert_not_nil coordinate[:longitude]
    end
  end

  test "should redirect with error message when cities parameter is blank" do
    post weather_forecasts_url, params: { cities: "" }
    assert_not_nil flash[:error]
    assert_equal "No se proporcionaron ciudades. Por favor ingresa al menos una ciudad.", flash[:error]
  end

  test "should redirect with error message when API call fails" do
    mock_service = Minitest::Mock.new
    def mock_service.get_coordinates(city)
      { error: "API error" }
    end
  
    ReservamosService.stub :new, mock_service do
      post weather_forecasts_url, params: { cities: "CDMX" }
      
      assert_not_nil flash[:error]
      assert_equal "Hubo un problema al obtener las coordenadas de la ciudad. Por favor intenta de nuevo más tarde.", flash[:error]
    end
  end
end
