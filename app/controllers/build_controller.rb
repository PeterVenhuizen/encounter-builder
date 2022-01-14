require 'securerandom'

class BuildController < ApplicationController
  before_action :init_encounter

  def index; end

  def add_player
    session[:players] << { name: params[:name], level: params[:level], id: SecureRandom.uuid }
    update
  end

  def delete_player
    session[:players].delete_if { |h| h['id'] == params[:id] }
    update
  end

  def add_monster
    session[:monsters] << { name: params[:name], cr: params[:cr], id: SecureRandom.uuid }
    update
  end

  def delete_monster
    session[:monsters].delete_if { |h| h['id'] == params[:id] }
    update
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
  end

  def update
    calc_encounter
    respond_to do |format|
      format.js { render 'build/update.js.erb' }
    end
  end

  def calc_encounter
    @encounter = Encounter.new
    @players = session[:players]
    @monsters = session[:monsters]

    # add all players to the party
    @players
      .map { |p| PlayerCharacter.new(p) }
      .each { |p| @encounter.party.join(p) }

    # add all monsters
    @monsters
      .map { |m| Monster.new(m) }
      .each { |m| @encounter.add_monster(m) }

    # calculate the difficulty
    @dto = @encounter.calculate_difficulty

    # debugger

    @dto
  end
end
