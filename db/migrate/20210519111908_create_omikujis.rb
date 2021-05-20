class CreateOmikujis < ActiveRecord::Migration[5.2]
  def change
    create_table :omikujis do |t|
      t.string :result
      t.string :content

      t.timestamps
    end
  end
end
