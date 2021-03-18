class AddGroupIdToMygroups < ActiveRecord::Migration[5.2]
  def change
    add_column :mygroups, :group_id, :string
  end
end
