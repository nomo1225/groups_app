class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :title
      t.string :content
      t.date :plan_on
      t.datetime :plan_at
      t.references :user, foreign_key: true
      t.references :mygroup, foreign_key: true

      t.timestamps
    end
  end
end
