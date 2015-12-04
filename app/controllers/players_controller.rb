class PlayersController < ApplicationController

  def index
    @avengers = Team.find 1
    avengers_team = Player.where('team_id =?', 1).order('is_star desc, sold_price desc')
    @avenger_players =  avengers_team - @avengers.owners
    @blasters = Team.find 2
    blasters_team = Player.where('team_id =?', 2).order('is_star desc, sold_price desc')
    @blaster_players = blasters_team - @blasters.owners
    @devils = Team.find 3
    devils_team = Player.where('team_id =?', 3).order('is_star desc, sold_price desc')
    @devil_players = devils_team - @devils.owners
    @termins = Team.find 4
    termins_team = Player.where('team_id =?', 4).order('is_star desc, sold_price desc')
    @termin_players = termins_team - @termins.owners
  end

  def get_player_details
    player = Player.includes(:team).find params[:id]
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

  def update_sold
    @sold =  Player.where(is_sold: true).where('sold_price is NOT NULL').order(sold_price: :desc)
    render :json => {:html => render_to_string(:partial => '/players/sold')}.to_json
  end
end
