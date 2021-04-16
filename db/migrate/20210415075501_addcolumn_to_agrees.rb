class AddcolumnToAgrees < ActiveRecord::Migration[5.2]
  def change
    add_reference :agrees, :user, foreign_key: true
    add_reference :agrees, :opinion, foreign_key: true
  end
end
