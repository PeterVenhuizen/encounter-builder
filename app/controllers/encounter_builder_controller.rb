require 'securerandom'

class EncounterBuilderController < ApplicationController
  before_action :init_encounter

  # GET /encounter-builder
  def index
    @encounter = Encounter.new
  end

  # GET /encounter-builder/:id
  def show; end

  # GET /encounter-builder/new
  def new
    @encounter = Encounter.new
  end

  # POST /encounter-builder
  def create
    params[:encounter][:monsters] = session[:monsters]
    @encounter = Encounter.new(encounter_params)
    puts @encounter.inspect
  end

  # PATCH/PUT /encounter-builder/:id
  def update; end

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

  def init_encounter
    session[:players] ||= []
    session[:monsters] ||= []
    @players = session[:players]
    @monsters = session[:monsters]
    @dto = calc_encounter

    @mon = Monster.all
  end

  def render_update
    calc_encounter
    respond_to do |format|
      format.js { render 'encounter_builder/update.js.erb' }
    end
  end

  def calc_encounter
    @eb = EncounterBuilder.new
    @players = session[:players]
    @monsters = session[:monsters]

    # add all players to the party
    @players
      .map { |p| PlayerCharacter.new(p) }
      .each { |p| @eb.party.join(p) }

    # add all monsters
    # @monsters
    #   .map { |m| Monster.new(m) }
    #   .each { |m| @encounter.add_monster(m) }
    puts session[:monsters]
    session[:monsters].each { |id| @eb.add_monster(Monster.find(id)) }

    # calculate the difficulty
    @dto = @eb.calculate_difficulty

    # debugger

    @dto
  end

  def encounter_params
    params.require(:encounter).permit(:name, :description, monsters: [])
  end
end
