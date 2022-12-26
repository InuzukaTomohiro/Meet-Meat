class Achievement < ApplicationRecord

  belongs_to :meat
  has_many   :user_achievements

end
