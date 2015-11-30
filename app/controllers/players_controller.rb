class PlayersController < ApplicationController

  def index
    @list = Player.all
    p @list.count
  end

  def get_player_details
    player = Player.includes(:team).find params[:id]
    render json: { success: true,
                   player_name: player.display_name,
                   team_name: player.team_name,
                   base: player.base_price,
                   sold: player.sold_price,
                   cricket: player.is_cricket,
                   football: player.is_football,
                   badminton: player.is_badminton,
                   status: player.is_sold
           }
  end

  def paginate
    @list = Player.all.paginate(:page => params[:page], :per_page => 18)
  end
end
