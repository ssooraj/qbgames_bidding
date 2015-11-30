class AddInforAuctionToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :in_for_auction, :boolean
    add_column :players, :sex, :string
  end
end
