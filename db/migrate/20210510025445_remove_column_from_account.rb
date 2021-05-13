class RemoveColumnFromAccount < ActiveRecord::Migration[5.2]
  def change
    remove_columns :accounts, :income, :expense
    add_column :accounts, :treasurer, :string
  end
end
