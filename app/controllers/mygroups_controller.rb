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

  def show
    @notices = @mygroup.notices.order(id: :desc).page(params[:page]).per(5)
    @discussions = @mygroup.discussions.order(id: :desc).page(params[:page]).per(5)
    
    #Mygroupの天気情報
    # unless @mygroup.area == "---"
    #   city = City.find_by(name: @mygroup.area)
    #   weather = Weather.find_by(location_id: city.location_id)
    #   if weather
    #     @weather_main = weather.weather_main
    #     @temp_min     = weather.temp_min
    #     @temp_max     = weather.temp_max
    #   end
    # end
  end
  
  def index #予定の表示
    @plans = @mygroup.plans.where('plans.start_time > ?', Date.yesterday).order(start_time: :asc).page(params[:page]).per(4)
    @plans_for_calender = @mygroup.plans.all
    
    # 経路検索(5/18 weatherからコピーのみ)
    # url = "https://api.openweathermap.org/data/2.5/weather"
    # url << "?id=#{city.location_id}"
    # url << "&appid=#{ENV['OPEN_WEATHER_API_KEY']}"
    # url << "&units=metric" #温度を摂氏に
    # client = HTTPClient.new #インスタンス生成
    # response = client.get(url) #GETリクエスト
    # hash =JSON.load(response.body).to_a  #JSON形式からhashへ
    # @weather_main = hash[1][1][0]['main']
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
    @relationships = @mygroup.relationships.order(id: :asc).page(params[:page]).per(15)
    @members = @mygroup.members
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
