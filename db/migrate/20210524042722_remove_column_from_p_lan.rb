class RemoveColumnFromPLan < ActiveRecord::Migration[5.2]
  def change
    remove_column :plans, :addres_title, :text
  end
end
