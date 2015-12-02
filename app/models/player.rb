class Player < ActiveRecord::Base
	belongs_to :team
	has_one :owning_team, class_name: 'Team', foreign_key: 'owner_id'
	has_one :co_owning_team, class_name: 'Team', foreign_key: 'co_owner_id'
	has_one :cricket_team, class_name: 'Team', foreign_key: 'cricket_captain_id'
	has_one :football_team, class_name: 'Team', foreign_key: 'football_captain_id'
	mount_uploader :avatar, AvatarUploader

	def display_name
		"#{first_name}" +' '+"#{last_name}"
	end

	def team_name
		team.name rescue ''
	end

	def self.generate_csv_for_mail_list
		CSV.generate do |csv|
			csv << ["First Name", "Last Name"]
			all.each do |user|
				csv << [user.first_name + " " + user.last_name, user.email]
			end
		end
	end

	def self.get_star params
		if params[:current].to_i == 0
			offset = Player.where(is_sold: false, not_sold: false,is_star:true).collect(&:id).sample
			return  Player.find offset
		else
			current = Player.find params[:current]
			current.not_sold = true
			current.save
			offset = Player.where(is_sold: false, not_sold: false,is_star:true).collect(&:id).sample
			player = Player.where(is_sold: false, not_sold: false,is_star:true).offset(offset).first
		end
		p player
	end
end
