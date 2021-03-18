class RenamePlanOnColumnToPlans < ActiveRecord::Migration[5.2]
  def change
    rename_column :plans, :plan_on, :start_time
  end
end
