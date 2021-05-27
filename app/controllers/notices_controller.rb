class NoticesController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_notice, only: [:show, :edit, :update, :destroy]
  before_action :create_member?, only: [:edit, :update, :destroy]
  before_action :group_member?, only: [:show]
  
  # Notice お知らせ機能
  
  def new
    @notice = Notice.new
    @mygroup_id = params[:mygroup_id]
    @mygroup = Mygroup.find(@mygroup_id)
    unless @mygroup.members.exists?(id: current_user.id)
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end

  def create
    @notice = Notice.new(notice_params)
    @mygroup_id = params[:notice][:mygroup_id]
    # 通知メール送信処理
    @mygroup = Mygroup.find(@mygroup_id)
    @members = @mygroup.members.where(unnotification: false)
    mygroup = @mygroup
    @members.each do |member|
      ContactMailer.new_notice_mail(member, mygroup).deliver_now
    end
    if @notice.save
      flash[:success] = 'お知らせを登録しました。'
      redirect_to mygroup_path(@notice.mygroup_id)
    else
      flash[:danger] = 'お知らせを登録できませんでした。'
      render :new
    end
  end
  
  def show
  end

  def edit
  end

  def update
    if @notice.update(notice_params)
      flash[:success] = 'お知らせを編集しました。'
      redirect_to mygroup_path(@notice.mygroup_id)
    else
      flash.now[:danger] = 'お知らせを編集できませんでした。'
      render :edit
    end
  end

  def destroy
    @notice.destroy
    flash[:success] = 'お知らせを削除しました。'
    redirect_to mygroup_path(@notice.mygroup_id)
  end
  
  private
  
  def set_notice
    @notice = Notice.find(params[:id])
  end
  
  def notice_params
    params.require(:notice).permit(:title, :content, :user_id, :mygroup_id)
  end
  
  def create_member? #予定作成者か
    @notice = Notice.find(params[:id])
    if @notice.user_id != current_user.id
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
  
  def group_member?
    @notice = Notice.find(params[:id])
    @mygroup = Mygroup.find(@notice.mygroup_id)
    unless @mygroup.members.exists?(id: current_user.id)
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
end
