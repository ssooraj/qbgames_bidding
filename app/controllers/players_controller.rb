class PlayersController < ApplicationController

  def index
    @list = Player.all
  end

  def get_player_details
    p params
    player = Player.find params[:id]
    render json: { success: true,
                   player_name: player.display_name
           }
  end
end
