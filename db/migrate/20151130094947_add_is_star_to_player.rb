class AddIsStarToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :is_star, :boolean
  end
end
