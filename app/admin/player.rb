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
