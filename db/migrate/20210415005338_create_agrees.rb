class CreateAgrees < ActiveRecord::Migration[5.2]
  def change
    create_table :agrees do |t|
      t.integer :user_id
      t.integer :opinion_id

      t.timestamps
    end
  end
end
