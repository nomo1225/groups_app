class AccountsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :create_member?, only: [:edit, :update, :destroy]
  before_action :group_member?, only: [:show]
  before_action :add_group?, only: [:new, :index, :total]
  
  # Account 会計情報
  
  def new
    @account = Account.new
    @mygroup_id = params[:mygroup_id] #グループと紐づけ用
    @mygroup = Mygroup.find(params[:mygroup_id])
    unless @mygroup.members.exists?(id: current_user.id)
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end

  def create
    @account = Account.new(account_params)
    @mygroup_id = params[:account][:mygroup_id]
    # 通知メール送信処理
    @mygroup = Mygroup.find(@mygroup_id)
    @members = @mygroup.members.where(unnotification: false)
    mygroup = @mygroup
    @members.each do |member|
      ContactMailer.new_account_mail(member, mygroup).deliver_now
    end
    if @account.save
      flash[:success] = '会計情報を登録しました。'
      redirect_to accounts_path(mygroup_id: @account.mygroup_id)
    else
      flash[:danger] = '会計情報を登録できませんでした。'
      render :new
    end
  end

  def show
  end

  def index
    @mygroup = Mygroup.find(params[:mygroup_id])
    @accounts = @mygroup.accounts.order(processed_date: :desc).page(params[:page]).per(10)
    # 全収入
    @income = Account.where(treasurer: "income", mygroup_id: @mygroup.id).sum(:fee)
    # 全支出
    @expense = Account.where(treasurer: "expense", mygroup_id: @mygroup.id).sum(:fee)
    
    @total = (@income - @expense)
  end
  
  def year_total #年ごと計 表示
    redirect_to total_path(mygroup_id: params[:mygroup_id], select_year: params[:select_year])
  end
  def total
    @mygroup = Mygroup.find(params[:mygroup_id])
    @select_year = params[:select_year]
    # processed_dateカラムの年で絞込
    @accounts = @mygroup.accounts.by_year(@select_year, field: :processed_date).order(processed_date: :desc).page(params[:page]).per(20)
    @income = Account.where(treasurer: "income", mygroup_id: @mygroup.id).by_year(@select_year, field: :processed_date).sum(:fee)
    @expense = Account.where(treasurer: "expense", mygroup_id: @mygroup.id).by_year(@select_year, field: :processed_date).sum(:fee)
    @total = (@income - @expense)
  end

  def edit
  end

  def update
    if @account.update(account_params)
      flash[:success] = '会計情報を編集しました。'
      redirect_to accounts_path(mygroup_id: @account.mygroup_id)
    else
      flash.now[:danger] = '会計情報を編集できませんでした。'
      render :edit
    end
  end

  def destroy
    @account.destroy
    flash[:success] = '会計情報を削除しました。'
    redirect_to accounts_path(mygroup_id: @account.mygroup_id)
  end
  
  private
  
  def set_account
    @account = Account.find(params[:id])
  end
  
  def account_params
    params.require(:account).permit(:processed_date, :treasurer, :to_whom, :content, :fee, :user_id, :mygroup_id)
  end
  
  def create_member? #会計登録者か
    @account = Account.find(params[:id])
    if @account.user_id != current_user.id
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
  
  def group_member?
    @account = Account.find(params[:id])
    @mygroup = Mygroup.find(@account.mygroup_id)
    unless @mygroup.members.exists?(id: current_user.id)
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
  
  def add_group?
    @mygroup = Mygroup.find(params[:mygroup_id])
    unless @mygroup.members.exists?(id: current_user.id)
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
    
  end
end
