class RemoveAgrees < ActiveRecord::Migration[5.2]
  def change
    drop_table :agrees
  end
end
