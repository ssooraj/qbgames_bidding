class PlayersController < ApplicationController

  def index
    @list = Player.all
  end

  def show
    p params
    @player = Player.find params[:id]
    render :layout => false
  end
end
