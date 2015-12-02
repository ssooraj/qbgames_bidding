class PlayersController < ApplicationController

  def index
    @star  = Player.where(in_for_auction: true, is_star: true).order(base_price: :desc)
    @guy   = Player.where(in_for_auction: true, is_star: false, sex: 'Dauntless Guy').order(base_price: :desc)
    @gal   = Player.where(in_for_auction: true, is_star: false, sex: 'Peppy Gal').order(base_price: :desc)
    @teams  = Team.all
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

  def player_list
    @users = Player.all.order(base_price: :desc)
    respond_to do |format|
      format.xls
    end
  end

  def get_player_for_auction
    player = case params[:type]
      when 'Star'
        Player.get_star params
      when 'Guy'
        Player.get_guy params
      when 'Gal'
        Player.get_gal params
    end
    render json: { success: true,
                   id: player.id,
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
end
