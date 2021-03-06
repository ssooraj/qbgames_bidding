class Team < ActiveRecord::Base
  has_many :players
  belongs_to :cricket_captain, class_name: 'Player'
  belongs_to :football_captain, class_name: 'Player'
  belongs_to :owner, class_name: 'Player'
  belongs_to :co_owner, class_name: 'Player'

  def owners
    [owner, co_owner, cricket_captain, football_captain]
  end
end
