class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :is_sold
      t.string :team

      t.timestamps null: false
    end
  end
end
