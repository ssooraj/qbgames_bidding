class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :manager 
      t.string :cricket_captain
      t.string :football_captain
      t.string :badminton_captain

      t.timestamps null: false
    end
  end
end
