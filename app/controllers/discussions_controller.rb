class DiscussionsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_discussion, only: [:show, :edit, :update, :destroy]
  before_action :create_member?, only: [:edit, :update, :destroy]
  before_action :group_member?, only: [:show]
  
  # 打合せ機能
  
  def new
    @discussion = Discussion.new
    @mygroup_id = params[:mygroup_id]
    @mygroup = Mygroup.find(@mygroup_id)
    unless @mygroup.members.exists?(id: current_user.id)
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @mygroup_id = params[:discussion][:mygroup_id]
    
    # 通知メール送信処理
    @mygroup = Mygroup.find(@mygroup_id)
    @members = @mygroup.members.where(unnotification: false)
    mygroup = @mygroup
    @members.each do |member|
      ContactMailer.send_for_everyone(member, mygroup).deliver_now
    end
    if @discussion.save
      flash[:success] = '打合せ項目を登録しました。'
      redirect_to mygroup_path(@discussion.mygroup_id)
    else
      flash[:danger] = '打合せ項目を登録できませんでした。'
      render :new
    end
  end

  def show #opinion:意見
    @opinions = Opinion.where(discussion_id: params[:id])
  end

  def edit
  end

  def update
    if @discussion.update(discussion_params)
      flash[:success] = '打合せ項目を編集しました。'
      redirect_to mygroup_path(@discussion.mygroup_id)
    else
      flash.now[:danger] = '打合せ項目を編集できませんでした。'
      render :edit
    end
  end

  def destroy
    @discussion.destroy
    flash[:success] = '打合せ項目を削除しました。'
    redirect_to mygroup_path(@discussion.mygroup_id)
  end
  
  private
  
  def set_discussion
    @discussion = Discussion.find(params[:id])
  end
  
  def discussion_params
    params.require(:discussion).permit(:title, :content, :user_id, :mygroup_id)
  end
  
  def create_member? #作成者か
    @discussion = Discussion.find(params[:id])
    if @discussion.user_id != current_user.id
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
  
  def group_member?
    @discussion = Discussion.find(params[:id])
    @mygroup = Mygroup.find(@discussion.mygroup_id)
    unless @mygroup.members.exists?(id: current_user.id)
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
end
