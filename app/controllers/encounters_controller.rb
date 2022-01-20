require 'securerandom'

class EncountersController < ApplicationController
  before_action :set_session, only: %i[new edit]
  before_action :set_encounter, only: %i[show edit update destroy]

  # GET /encounters
  def index
    @encounters = Encounter.all
  end

  # GET /encounters/:id
  def show; end

  # GET /encounters/new
  def new
    @encounter = Encounter.new
  end

  # Get /encounters/:id/edit
  def edit
    session[:monsters] = @encounter.monsters
    calc_encounter
  end

  # POST /encounters
  def create
    params[:encounter][:monsters] = session[:monsters]
    @encounter = Encounter.new(encounter_params)

    respond_to do |format|
      if @encounter.save
        session[:monsters] = []
        format.html { redirect_to encounter_url(@encounter), notice: 'Encounter was successfully created.' }
      else
        calc_encounter
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /encounters/:id
  def update
    params[:encounter][:monsters] = session[:monsters]
    respond_to do |format|
      if @encounter.update(encounter_params)
        format.html { redirect_to encounter_url(@encounter), notice: 'Encounter was successfully updated.' }
      else
        calc_encounter
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /encounters/:id
  def destroy
    @encounter.destroy

    respond_to do |format|
      format.html { redirect_to encounters_url, notice: 'Encounter was successfully deleted.' }
    end
  end

  def add_player
    session[:players] << { name: params[:name], level: params[:level], id: SecureRandom.uuid }
    render_update
  end

  def delete_player
    session[:players].delete_if { |h| h['id'] == params[:id] }
    render_update
  end

  def add_monster
    session[:monsters] << params[:id]
    render_update
  end

  def delete_monster
    session[:monsters].slice!(session[:monsters].index(params[:id]))
    render_update
  end

  def reset
    reset_session
    respond_to do |format|
      format.js { render inline: 'location.reload();' }
    end
  end

  private

  def set_encounter
    @encounter = Encounter.find(params[:id])
  end

  def set_session
    session[:players] ||= []
    session[:monsters] = []
    @players = session[:players]
    @monsters = []
    calc_encounter
  end

  def render_update
    calc_encounter
    respond_to do |format|
      format.js { render 'encounters/update.js.erb' }
    end
  end

  def calc_encounter
    @encounter_calculator = EncounterCalculator.new
    @players = session[:players]
    @monsters = session[:monsters]

    # add all players to the party
    @players
      .map { |p| PlayerCharacter.new(p) }
      .each { |p| @encounter_calculator.party.join(p) }

    # add all monsters
    session[:monsters].each { |id| @encounter_calculator.add_monster(Monster.find(id)) }

    @summary = @encounter_calculator.summary
  end

  def encounter_params
    params.require(:encounter).permit(:name, :description, monsters: [])
  end
end
