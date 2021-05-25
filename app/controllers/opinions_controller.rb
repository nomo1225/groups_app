class OpinionsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_opinion, only: [:destroy]
  before_action :create_member?, only: [:destroy]
  before_action :group_member?, only: [:index]
  
  # Opinion 意見(打合せ(discussion)に対して)
  
  def new
    @opinion = Opinion.new
    @mygroup_id = params[:mygroup_id]
    @discussion_id = params[:discussion_id]
    @mygroup = Mygroup.find(@mygroup_id)
    unless @mygroup.members.exists?(id: current_user.id)
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end

  def create
    @opinion = Opinion.new(opinion_params)
    @mygroup_id = params[:opinion][:mygroup_id]
    @discussion_id = params[:opinion][:discussion_id]
    if @opinion.save
      flash[:success] = '意見を登録しました。'
      redirect_to discussion_path(@opinion.discussion)
    else
      flash[:danger] = '意見を登録できませんでした。'
      render :new
    end
  end

  def index
    @opinions = Opinion.where(discussion_id: params[:id]).order(id: :desc).page(params[:page]).per(5)
    @agree = Agree.new
  end

  def destroy
    @opinion.destroy
    flash[:success] = '意見を削除しました。'
    redirect_to discussion_path(@opinion.discussion)
  end
  
  private
  
  def set_opinion
    @opinion = Opinion.find(params[:id])
  end
  
  def opinion_params
    params.require(:opinion).permit(:content, :user_id, :mygroup_id, :discussion_id)
  end
  
  def create_member? #作成者か
    @opinion = Opinion.find(params[:id])
    if @opinion.user_id != current_user.id
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
  
  def group_member?
    @opinion = Opinion.find(params[:id])
    @mygroup = Mygroup.find(@opinion.mygroup_id)
    unless @mygroup.members.exists?(id: current_user.id)
      flash[:danger] = '権限がありません。'
      redirect_to root_path
    end
  end
end
