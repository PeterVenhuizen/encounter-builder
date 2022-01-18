class Monster < ApplicationRecord
  include XP
  default_scope { order(name: :asc) }

  def xp
    XP_BY_CHALLENGE_RATING[challenge_rating]
  end
end
