class CreateDiscussions < ActiveRecord::Migration[5.2]
  def change
    create_table :discussions do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.references :mygroup, foreign_key: true

      t.timestamps
    end
  end
end
