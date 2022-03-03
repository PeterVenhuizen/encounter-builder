class CombatTrackerPresenter
  include ApplicationHelper

  def initialize(combat_tracker)
    @combat_tracker = combat_tracker
  end

  def name
    @combat_tracker.encounter.name
  end

  def description
    markdown(@combat_tracker.encounter.description)
  end
end
