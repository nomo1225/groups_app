class MygroupsController < ApplicationController
  require 'date'
  require 'httpclient'
  require 'json'
  
  before_action :require_user_logged_in
  before_action :set_mygroup, only: [:show, :index, :edit, :update, :destroy, :members]
  before_action :representative?, only: [:edit, :update, :destroy]
  before_action :member?, only: [:show, :members, :index]
  
  def new
    @mygroup = Mygroup.new
  end

  def create
    @mygroup = Mygroup.new(mygroup_params)
    if @mygroup.save
      current_user.join(@mygroup)
      flash[:success] = 'グループを登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '登録に失敗しました。'
      render :new
    end
  end

  def show #Mygroupの天気情報
    @notices = @mygroup.notices.order(id: :desc).page(params[:page]).per(15)
    
    city = City.find_by(name: @mygroup.area)
    url = "https://api.openweathermap.org/data/2.5/weather"
    url << "?id=#{city.location_id}"
    url << "&appid=#{ENV['OPEN_WEATHER_API_KEY']}"
    url << "&units=metric"
    client = HTTPClient.new
    response = client.get(url)
    hash =JSON.load(response.body).to_a
    @weather_main = hash[1][1][0]['main']
    @temp_min = hash[3][1]['temp_min'].round
    @temp_max = hash[3][1]['temp_max'].round
  end
  
  def index #予定の表示
    @plans = @mygroup.plans.where('plans.start_time > ?', Date.yesterday).order(start_time: :asc).page(params[:page]).per(4)
    @plans_for_calender = @mygroup.plans.all
  end

  def edit
  end
  
  def update
    if @mygroup.update(mygroup_params2)
      flash[:success] = '登録情報を更新しました！'
      redirect_to @mygroup
    else
      flash.now[:danger] = '登録情報は更新されませんでした。'
      render :edit
    end
  end

  def destroy
    @mygroup.destroy
    flash[:success] = 'グループを削除しました。'
    redirect_to root_path
  end
  
  def members #メンバー一覧
    @user = User.find(current_user.id)
    @members = @mygroup.members.order(id: :desc).page(params[:page]).per(15)
  end
  
  private
  
  def set_mygroup
    @mygroup = Mygroup.find(params[:id])
  end
  
  def mygroup_params
    params.require(:mygroup).permit(:name, :area, :user_id, :category, :image, :group_id)
  end
  
  def mygroup_params2 #update用
    params.require(:mygroup).permit(:name, :area, :user_id, :category, :image)
  end
  
  def representative? #グループの作成者か
    @mygroup = Mygroup.find(params[:id])
    if @mygroup.user_id != current_user.id
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
  
  def member? #グループのメンバーか
    @mygroup = Mygroup.find(params[:id])
    unless @mygroup.members.exists?(id: current_user.id)
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
end
