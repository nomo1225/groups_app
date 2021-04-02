class RenameCityIdColumnToWeathers < ActiveRecord::Migration[5.2]
  def change
    rename_column :weathers, :city_id, :location_id
  end
end
