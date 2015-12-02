class AddNotSoldToPlayer < ActiveRecord::Migration
  def change
    add_column    :players, :not_sold, :boolean,  default: false
  end
end
