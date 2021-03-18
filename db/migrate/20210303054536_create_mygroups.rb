class CreateMygroups < ActiveRecord::Migration[5.2]
  def change
    create_table :mygroups do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :area
      t.string :category
      t.string :image

      t.timestamps
    end
  end
end
