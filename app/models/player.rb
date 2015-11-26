class Player < ActiveRecord::Base
	belongs_to :team
	mount_uploader :avatar, AvatarUploader
end
