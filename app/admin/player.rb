ActiveAdmin.register Player do
  permit_params :first_name, :last_name, :is_sold, :team_id, :created_at, :updated_at, :avatar,
                :is_cricket, :is_football, :is_badminton, :base_price, :sold_price

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
            row('image') { image_tag resource.avatar.thumb.url rescue nil}
          end
        end
      end
    end
  end
end
