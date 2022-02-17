class MonsterPresenter
  def initialize(monster)
    @monster = monster
  end

  def big_name
    @monster.name.upcase
  end

  def size_type_and_alignment
    "#{@monster.size} #{@monster.species}, #{@monster.alignment}".humanize
  end

  def hp
    "#{@monster.hit_points} (#{@monster.hit_dice})"
  end

  def speed
    @monster.speed.filter { |_, v| !v.to_i.zero? }
                  .map { |k, v| "#{k} #{v} ft." }
                  .join(', ')
                  .sub("walk ", '')
  end

  def shorten(ability)
    ability.slice(0, 3).upcase
  end

  def score_and_modifier(score)
    mod = prepend_sign((score.to_i - 10) / 2)
    "#{score} (#{mod})"
  end

  def languages
    @monster.languages.blank? ? '&#8212;'.html_safe : @monster.languages
  end

  def challenge_and_xp
    "#{@monster.challenge_rating} (#{ActiveSupport::NumberHelper.number_to_delimited(@monster.xp)} XP)"
  end

  def proficiency_bonus
    prepend_sign(@monster.proficiency_bonus)
  end

  private

  def prepend_sign(value)
    "%+d" % value
  end
end
