ActiveAdmin.register Player do
  permit_params :first_name, :last_name, :is_sold, :team_id, :created_at, :updated_at, :avatar,
                :is_cricket, :is_football, :is_badminton, :base_price, :sold_price, :is_star,
                :sex, :in_for_auction, :not_sold

  collection_action :refresh_unsold, method: :post do
    players = Player.where(is_sold: false, not_sold: true,in_for_auction:true)
    players.each do |player|
      player.not_sold = false
      player.base_price = 10
      player.save
    end
    redirect_to admin_players_path, notice: "CSV imported successfully!"
  end

  action_item only: :index do
    link_to 'Refresh Unsold', refresh_unsold_admin_players_path, method: :post
  end

  show do
    panel "Contents" do
      tabs do
        tab "Profile" do
          attributes_table_for resource do
            row :id
            row :first_name
            row :last_name
            row :is_sold
            row :team
            row :is_cricket
            row :is_football
            row :is_badminton
            row :base_price
            row('image') { image_tag resource.avatar.thumb.url rescue nil}
          end
        end
      end
    end
  end

  index do
    id_column
    column :first_name
    column :last_name
    column :is_sold
    column :is_cricket
    column :is_football
    column :is_badminton
    column :base_price
    actions
  end
end
