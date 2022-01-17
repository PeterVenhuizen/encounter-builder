class Monster < ApplicationRecord
  include XP

  def xp
    XP_BY_CHALLENGE_RATING[challenge_rating]
  end
end
