class OmikujisController < ApplicationController
  def show
    random = rand(1..51)
    @omikuji = Omikuji.find(random)
  end
end
