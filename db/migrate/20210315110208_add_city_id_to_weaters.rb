class AddCityIdToWeaters < ActiveRecord::Migration[5.2]
  def change
    add_column :weathers, :city_id, :integer
  end
end
