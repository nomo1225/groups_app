class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @relationship = Relationship.new
  end
  
  def create
    mygroup = Mygroup.find_by(group_id: params[:relationship][:group_id])
    if mygroup.present? && mygroup.name == params[:relationship][:name] && current_user.join(mygroup)
      flash[:success] = 'グループに参加しました。'
      redirect_to root_path
    else
      flash[:danger] = '参加できませんでした。グループ名とIDの組合せが間違っています。'
      redirect_to root_path
    end
  end

  def destroy
    mygroup = Mygroup.find(params[:mygroup_id])
    current_user.secession(mygroup)
    flash[:success] = 'グループから退会しました。'
    redirect_to root_path
  end
  
end
