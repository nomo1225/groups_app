class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user          = User.find(current_user.id)
      @mygroup       = current_user.mygroups.build
      @made_mygroups = current_user.mygroups.order(id: :asc).page(params[:page])
      @mygroups      = current_user.joined_mygroups.order(id: :asc).page(params[:page])
      random = rand(1..51)
      @omikuji = Omikuji.find(random)
    end
  end
  
  def terms
  end
  
  def privacy_policy
  end
  
  def question
  end
  
  def how_to_use
  end
end
