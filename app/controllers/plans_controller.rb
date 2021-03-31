class PlansController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :create_member?, only: [:edit, :update, :destroy]
  before_action :group_member?, only: [:show]
  
  def new
    @plan = Plan.new
    @mygroup_id = params[:mygroup_id]
    @mygroup = Mygroup.find(@mygroup_id)
    unless @mygroup.members.exists?(id: current_user.id) #グループメンバーか
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end

  def create
    @plan = Plan.new(plan_params)
    @mygroup_id = params[:plan][:mygroup_id]
    if @plan.save
      flash[:success] = '予定を登録しました。'
      #redirect_to "/mygroups/#{@plan.mygroup_id}/plans" (最初の書き方。以下に修正)
      redirect_to mygroup_plans_path(id: @plan.mygroup_id)
    else
      flash[:danger] = '予定を登録できませんでした。'
      render :new
    end
  end

  def show
    @attendances = Attendance.where(plan_id: @plan.id)
  end

  def edit
  end

  def update
    if @plan.update(plan_params)
      flash[:success] = '予定を編集しました。'
      redirect_to mygroup_plans_path(id: @plan.mygroup_id)
    else
      flash.now[:danger] = '予定を編集できませんでした。'
      render :edit
    end
  end

  def destroy
    @plan.destroy
    flash[:success] = '予定を削除しました。'
    redirect_to mygroup_plans_path(id: @plan.mygroup_id)
  end
  
  private
  
  def set_plan
    @plan = Plan.find(params[:id])
  end
  
  def plan_params
    params.require(:plan).permit(:title, :content, :start_time, :plan_at, :user_id, :mygroup_id)
  end
  
  def create_member?
    @plan = Plan.find(params[:id])
    if @plan.user_id != current_user.id
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
  
  def group_member?
    @plan = Plan.find(params[:id])
    @mygroup = Mygroup.find(@plan.mygroup_id)
    unless @mygroup.members.exists?(id: current_user.id)
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
end
