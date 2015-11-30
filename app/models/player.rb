class Player < ActiveRecord::Base
	belongs_to :team
	mount_uploader :avatar, AvatarUploader

	def display_name
		"#{first_name}" +' '+"#{last_name}"
	end

	def team_name
		team.name rescue ''
	end
end
