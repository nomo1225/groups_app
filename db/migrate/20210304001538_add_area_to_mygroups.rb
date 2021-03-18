class AddAreaToMygroups < ActiveRecord::Migration[5.2]
  def change
    add_column :mygroups, :area, :integer
  end
end
