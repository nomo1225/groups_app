class CreateNotices < ActiveRecord::Migration[5.2]
  def change
    create_table :notices do |t|
      t.string :title
      t.string :content
      t.references :user, foreign_key: true
      t.references :mygroup, foreign_key: true

      t.timestamps
    end
  end
end
