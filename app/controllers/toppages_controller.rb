class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = User.find(current_user.id)
      @mygroup = current_user.mygroups.build
      @made_mygroups = current_user.mygroups.order(id: :asc).page(params[:page])
      @mygroups = current_user.joined_mygroups.order(id: :asc).page(params[:page])
    end
  end
  
  def about
  end
end
