class AddIndexToMygroups < ActiveRecord::Migration[5.2]
  def change
    add_index :mygroups, :group_id, unique: true
  end
end
