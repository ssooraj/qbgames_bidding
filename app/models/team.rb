class Team < ActiveRecord::Base
  has_many :players
  belongs_to :cricket_captain, class_name: 'Player'
  belongs_to :football_captain, class_name: 'Player'
  belongs_to :manager, class_name: 'Player'
end
