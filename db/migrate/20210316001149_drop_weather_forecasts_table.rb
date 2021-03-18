class DropWeatherForecastsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :weather_forecasts
  end
end
