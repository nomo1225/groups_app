class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.date :processed_date
      t.string :income
      t.string :expense
      t.string :to_whom
      t.string :content
      t.integer :fee
      t.references :user, foreign_key: true
      t.references :mygroup, foreign_key: true

      t.timestamps
    end
  end
end
