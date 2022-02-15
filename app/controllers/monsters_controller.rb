class MonstersController < ApplicationController
  before_action :set_monster, only: %i[ show edit update destroy ]

  # GET /monsters or /monsters.json
  def index
    @monsters = Monster.all
  end

  # GET /monsters/1 or /monsters/1.json
  def show
  end

  def search
    dnd_client = Dnd5eAPI::Client.new
    response = dnd_client.monster_by_name(params[:search])

    debugger

    if response.ok?
      # make monster from params
      params = ActionController::Parameters.new(response.params)
      @monster = Monster.new(monster_params)
      # render stat-block and re-render form
      # flash.now[:info] = "Monster available and form filled."
    else
      # flash monster not found
      # flash.now[:alert] = "Monster not found."
    end
  end

  # GET /monsters/new
  def new
    @monster = Monster.new
  end

  # GET /monsters/1/edit
  def edit
  end

  # POST /monsters or /monsters.json
  def create
    @monster = Monster.new(monster_params)

    respond_to do |format|
      if @monster.save
        format.html { redirect_to monster_url(@monster), notice: "Monster was successfully created." }
        format.json { render :show, status: :created, location: @monster }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monsters/1 or /monsters/1.json
  def update
    respond_to do |format|
      if @monster.update(monster_params)
        format.html { redirect_to monster_url(@monster), notice: "Monster was successfully updated." }
        format.json { render :show, status: :ok, location: @monster }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monsters/1 or /monsters/1.json
  def destroy
    @monster.destroy

    respond_to do |format|
      format.html { redirect_to monsters_url, notice: "Monster was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monster
      @monster = Monster.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def monster_params
      params.require(:monster).permit(:name, :size, :species, :alignment, :armor_class, :hit_points,
                                      :hit_dice, :challenge_rating, { ability_scores: {} }, :xp)
    end
end
