class AddMoreDetailsToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :team_id, :integer
    add_column :players, :avatar, :string
    remove_column :players, :team
  end
end
