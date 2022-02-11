class EncounterPresenter
  attr_reader :difficulty

  def initialize(encounter)
    @encounter = encounter
    @difficulty = encounter.calculate_statistics[:difficulty]
  end

  def number_of_monsters
    @encounter.fates.sum(&:group_size)
  end

  def created_at
    @encounter.created_at.strftime('%d-%B-%Y')
  end
end
