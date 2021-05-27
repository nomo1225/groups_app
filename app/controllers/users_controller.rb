class UsersController < ApplicationController
  require 'securerandom' #乱数発生器サポート(token)
  
  before_action :require_user_logged_in, except: [:new, :create, :forget, :forgetmail, :resetpass, :runresetpass] #ログイン不要
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
      ContactMailer.signup_mail(@user).deliver_now
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
  
  #パスワードリセット
  def forget
    @user = User.new
  end
  def forgetmail
    @user = User.find_by(email: params[:email])
    if @user
      @token = SecureRandom.hex(13) #ランダム文字列生成
      @user.assign_attributes(reset_token: @token) #userのreset_tokenに@token代入
      @user.save(validate: false) #パスワードのバリデーションがかからないよう指定
      ContactMailer.forget_pass(@user).deliver_now
      flash[:success] = 'パスワード再設定用メールを送信しました。'
      redirect_to login_path
    else
      flash.now[:danger] = 'このメールアドレスの登録はありません。'
      render :forget
    end
  end
  
  def resetpass
    if params[:reset_token] == nil || User.find_by(reset_token: params[:reset_token]) ==nil
      flash[:danger] = 'トークンが無効です。再度パスワード再設定メールを送信してください。'
      redirect_to login_path
    end
    @user = User.find_by(reset_token: params[:reset_token])
  end
  def runresetpass
    @user = User.find(params[:user_id])
    unless @user
      flash[:danger] = '不正なアクセスです。' 
      redirect_to root_path
    else
      if @user.update(passwordreset_params)
        @user.assign_attributes(reset_token: nil) #トークンリセット
        @user.save(validate: false)
        flash[:success] = 'パスワードを再設定しました。'
        redirect_to login_path
      else
        flash.now[:danger] = 'パスワード再設定に失敗しました。'
        render :resetpass
      end
    end
  end
  
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :unnotification)
  end
  
  def identification
    @user = User.find(params[:id])
    if @user != current_user
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
  
  def passwordreset_params
    params.permit(:password, :password_confirmation)
  end
  
end
