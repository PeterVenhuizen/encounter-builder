class CombatTrackersController < ApplicationController
  before_action :set_combat_tracker, only: %i[show update destroy]

  def show
  end

  def create
    encounter = Encounter.find(params[:encounter_id])
    @combat_tracker = encounter.build_combat_tracker
    
    respond_to do |format|
      if @combat_tracker.save
        format.html { redirect_to combat_tracker_url(@combat_tracker), 
                      flash: { success: "Combat was successfully started." } }
      else
        format.html { flash[:warning] = "Something has gone wrong :(" }
      end
    end
  end

  private

    def set_combat_tracker
      @combat_tracker = CombatTracker.find(params[:id])
    end
end
