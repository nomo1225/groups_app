class UsersController < ApplicationController
  before_action :require_user_logged_in, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :identification, only: [:edit, :update, :destroy]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(15)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'ユーザを登録しました！'
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザ登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = '登録情報を更新しました！'
      redirect_to root_path
    else
      flash.now[:danger] = '登録情報は更新されませんでした。'
      render :edit
    end
  end

  def destroy
    @user.destroy
    
    flash[:success] = 'ユーザ情報は削除されました。'
    redirect_to root_url
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
  
  def identification
    @user = User.find(params[:id])
    if @user != current_user
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
end
