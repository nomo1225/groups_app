class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :user, foreign_key: true
      t.references :plan, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :plan_id], unique: true
    end
  end
end
