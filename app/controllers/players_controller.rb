class PlayersController < ApplicationController

  def index
    @list = Player.all
  end

  def get_player_details
    p params
    player = Player.includes(:team).find params[:id]
    render json: { success: true,
                   player_name: player.display_name,
                   team_name: player.team.name,
                   base: player.base_price,
                   sold: player.sold_price,
                   cricket: player.is_cricket,
                   football: player.is_football,
                   badminton: player.is_badminton
           }
  end
end
