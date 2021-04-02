class CreateWeathers < ActiveRecord::Migration[5.2]
  def change
    create_table :weathers do |t|
      t.string :weather_main
      t.integer :temp_min
      t.integer :temp_max

      t.timestamps
    end
  end
end
