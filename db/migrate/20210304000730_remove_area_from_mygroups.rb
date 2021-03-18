class RemoveAreaFromMygroups < ActiveRecord::Migration[5.2]
  def change
    remove_column :mygroups, :area, :string
  end
end
