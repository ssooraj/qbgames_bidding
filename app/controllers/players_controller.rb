class PlayersController < ApplicationController

  def index
    @list = Player.where(in_for_auction: true).order(is_star: :desc, base_price: :desc)
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
                   status: player.is_sold,
                   star: player.is_star,
                   sex: player.sex
           }
  end

  def paginate
    @list = Player.where(in_for_auction: true).
        paginate(:page => params[:page], :per_page => 18)
  end
end
