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
    assert_response :success

    coordinates = assigns(:coordinates)
    assert_not_nil coordinates
    assert_equal 4, coordinates.length

    coordinates.each do |coordinate|
      assert_not_nil coordinate[:latitude]
      assert_not_nil coordinate[:longitude]
    end
  end
end
