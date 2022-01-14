require 'securerandom'

class BuildController < ApplicationController
  before_action :init_encounter

  def index; end

  def player
    if params.key?('uuid')
      session[:players].delete_if { |h| h['uuid'] == params[:uuid] }
    else
      session[:players] << { name: params[:name],
                             level: params[:level],
                             uuid: SecureRandom.uuid }
    end
    calc_encounter
  end

  def monster
    if params.key?('uuid')
      session[:monsters].delete_if { |h| h['uuid'] == params[:uuid] }
    else
      session[:monsters] << { name: params[:name],
                              cr: params[:cr],
                              uuid: SecureRandom.uuid }
    end
    calc_encounter
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
