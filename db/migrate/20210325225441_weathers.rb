class Weathers < ActiveRecord::Migration[5.2]
  def change
    drop_table :weathers
  end
end
