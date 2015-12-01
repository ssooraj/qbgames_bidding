class ChangeColumnTypeinTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :cricket_captain
    remove_column :teams, :football_captain
    remove_column :teams, :badminton_captain
    remove_column :teams, :manager
    add_column    :teams, :cricket_captain_id, :integer
    add_column    :teams, :football_captain_id, :integer
    add_column    :teams, :manager_id, :integer
  end
end
