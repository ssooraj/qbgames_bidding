class PlayersController < ApplicationController

  def index
    @list = Player.all
  end
end
