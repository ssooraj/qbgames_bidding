class Player < ActiveRecord::Base
	belongs_to :team
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
end
