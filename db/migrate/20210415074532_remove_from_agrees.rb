class RemoveFromAgrees < ActiveRecord::Migration[5.2]
  def change
    remove_column :agrees, :user_id, :integer
    remove_column :agrees, :opinion_id, :integer
  end
end
