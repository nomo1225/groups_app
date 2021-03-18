class AddWeatherMainToWethers < ActiveRecord::Migration[5.2]
  def change
    add_column :weathers, :weather_main, :string
    remove_column :weathers, :weather_id, :integer
  end
end
