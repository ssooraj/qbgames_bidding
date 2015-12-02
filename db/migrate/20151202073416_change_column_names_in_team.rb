class ChangeColumnNamesInTeam < ActiveRecord::Migration
  def change
    remove_column :teams, :manager_id
    add_column    :teams, :owner_id, :integer
    add_column    :teams, :co_owner_id, :integer
  end
end
