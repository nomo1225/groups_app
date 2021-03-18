class MygroupsController < ApplicationController
  require 'date'
  require 'httpclient'
  require 'json'
  
  before_action :require_user_logged_in
  before_action :set_mygroup, only: [:show, :index, :edit, :update, :destroy, :members]
  before_action :representative?, only: [:edit, :update, :destroy, :show]
  
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
    @notices = @mygroup.notices.order(id: :desc).page(params[:page]).per(15)
    
    city = City.find_by(name: @mygroup.area)
    url = "https://api.openweathermap.org/data/2.5/weather?id=#{city.location_id}&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=metric"
    client = HTTPClient.new
    response = client.get(url)
    hash =JSON.load(response.body).to_a
    @weather_main = hash[1][1][0]['description']
    @temp_min = hash[3][1]['temp_min'].round
    @temp_max = hash[3][1]['temp_max'].round
  end
  
  def index
    @plans = @mygroup.plans.where('plans.start_time > ?', Date.today).order(start_time: :asc).page(params[:page]).per(4)
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
  
  def members
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
  
  def mygroup_params2
    params.require(:mygroup).permit(:name, :area, :user_id, :category, :image)
  end
  
  def representative?
    @mygroup = Mygroup.find(params[:id])
    if @mygroup.user_id != current_user.id
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
end
