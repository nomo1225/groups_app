class NoticesController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_notice, only: [:show, :edit, :update, :destroy]
  before_action :create_member?, only: [:edit, :update, :destroy]
  
  def new
    @notice = Notice.new
 
  end

  def create
    @notice = Notice.new(notice_params)
    if @notice.save
      flash[:success] = 'お知らせを登録しました。'
      redirect_to mygroup_path(@notice.mygroup_id)
    else
      flash[:danger] = 'お知らせを登録できませんでした。
                        タイトル(全角25字以内)・内容(全角100字以内)は入力必須です。'
      redirect_to mygroup_path(@notice.mygroup_id)
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
  
  def create_member?
    @notice = Notice.find(params[:id])
    if @notice.user_id != current_user.id
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
end
