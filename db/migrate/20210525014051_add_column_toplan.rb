class AddColumnToplan < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :plan_until, :datetime
  end
end
