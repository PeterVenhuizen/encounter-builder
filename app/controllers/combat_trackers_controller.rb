class CombatTrackersController < ApplicationController
  before_action :set_combat_tracker, only: %i[show update next_turn destroy]

  def show
    # @combat_tracker = CombatTracker.find(params[:id])
    @combat_tracker.combatants.build
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

  def update
    respond_to do |format|
      if @combat_tracker.update(combat_tracker_params)
        format.html { redirect_to combat_tracker_url(@combat_tracker), 
                      flash: { success: "Combat was successfully updated." } }
      else
        format.html { render :show, status: :unprocessable_entity,
                      flash: { warning: "Something has gone wrong :(" } }
      end
    end
  end

  def next_turn
    @combat_tracker.next_turn
    @combat_tracker.save
    redirect_to combat_tracker_url(@combat_tracker)
  end

  private

    def set_combat_tracker
      @combat_tracker = CombatTracker.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def combat_tracker_params
      params.require(:combat_tracker).permit(
        combatants_attributes: %i[initiative current_hp max_hp _destroy id]
      )
    end
end
