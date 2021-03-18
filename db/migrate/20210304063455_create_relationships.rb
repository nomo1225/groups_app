class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :mygroup, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :mygroup_id], unique: true
    end
  end
end
