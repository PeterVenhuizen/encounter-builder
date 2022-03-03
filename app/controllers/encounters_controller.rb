class EncountersController < ApplicationController
  before_action :set_encounter, only: %i[show edit update destroy]

  def index
    @encounters = Encounter.all
  end

  def show; end

  def new
    @encounter = Encounter.new
    @encounter.fates.build
    @party = Party.new
  end

  def edit
    @party = Party.find(@encounter.party.id)
  end

  def create
    @encounter = Encounter.create(encounter_params)

    respond_to do |format|
      if @encounter.save
        format.html { redirect_to @encounter, notice: 'Encounter was successfully created.' }
        format.json { render :show, status: :created, location: @encounter }
      else
        format.html { render :new }
        format.json { render json: @encounter.errors, status: :unproccessable_entity }
      end
    end
  end

  def update
    @encounter = Encounter.find(params[:id])

    if @encounter.update(encounter_params)
      redirect_to @encounter
    else
      render action: 'edit'
    end
  end

  def destroy
    @encounter.destroy

    respond_to do |format|
      format.html { redirect_to encounters_url, notice: 'Encounter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def party_stats
    @party = Party.where(id: params[:id]).exists? ? Party.find(params[:id]) : Party.new
  end

  def encounter_stats
    @encounter = Encounter.new(
      party_id: params[:party_id],
      fates_attributes: JSON.parse(params[:fates_attributes])
    )
  end

  def search
    @encounter = Encounter.new
    @monsters = params[:search].empty? ? [] : Monster.where('lower(name) LIKE ?', "%#{params[:search]}%")
    render layout: false
  end

  private

  def set_encounter
    @encounter = Encounter.find(params[:id])
  end

  def encounter_params
    params.require(:encounter).permit(
      :name, :description, :party_id,
      fates_attributes: %i[group_size monster_id _destroy id]
    )
  end
end
