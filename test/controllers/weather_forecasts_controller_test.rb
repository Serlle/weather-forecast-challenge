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
end
