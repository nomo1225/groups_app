class PlansController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :create_member?, only: [:edit, :update, :destroy]
  
  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      flash[:success] = '予定を登録しました。'
      redirect_to "/mygroups/#{@plan.mygroup_id}/plans"
    else
      flash[:danger] = '予定を登録できませんでした。
                        全項目入力必須です。タイトル・内容は全角20字以内。'
      redirect_to "/mygroups/#{@plan.mygroup_id}/plans"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @plan.update(plan_params)
      flash[:success] = '予定を編集しました。'
      redirect_to "/mygroups/#{@plan.mygroup_id}/plans"
    else
      flash.now[:danger] = '予定を編集できませんでした。'
      render :edit
    end
  end

  def destroy
    @plan.destroy
    flash[:success] = '予定を削除しました。'
    redirect_to "/mygroups/#{@plan.mygroup_id}/plans"
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
end
