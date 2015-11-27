class AddPriceDetailsToUser < ActiveRecord::Migration
  def change
    add_column :players, :base_price, :float
    add_column :players, :sold_price, :float
    add_column :players, :is_cricket, :boolean
    add_column :players, :is_football, :boolean
    add_column :players, :is_badminton, :boolean
  end
end
