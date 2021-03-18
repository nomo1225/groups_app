class AttendancesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    plan = Plan.find(params[:plan_id])
    current_user.attend(plan)
    flash[:success] = '予定に参加しました。'
    redirect_to "/mygroups/#{plan.mygroup_id}/plans"
  end

  def destroy
    plan = Plan.find(params[:plan_id])
    current_user.unattend(plan)
    flash[:success] = '不参加にしました。'
    redirect_to "/mygroups/#{plan.mygroup_id}/plans"
  end
end
