require 'securerandom'

class BuildController < ApplicationController
  before_action :counter

  def index; end

  def test
    @counter = session[:counter]
    @counter = params[:something] == 'plus' ? @counter += 1 : @counter -= 1
    session[:counter] = @counter
  end

  def player
    if params.key?('uuid')
      puts params[:uuid]
      session[:players].delete_if { |h| h['uuid'] == params[:uuid] }
    else
      session[:players] << { name: params[:name],
                             level: params[:level],
                             uuid: SecureRandom.uuid }
    end
    puts session[:players]
    puts "#players: #{session[:players].count}"

    # debugger

    encounter
    # render partial :player
    # render partial :encounter
  end

  def monster
    if params.key?('uuid')
      session[:monsters].delete_if { |h| h['uuid'] == params[:uuid] }
    else
      session[:monsters] << { name: params[:name],
                              cr: params[:cr],
                              uuid: SecureRandom.uuid }
    end

    encounter
    # render :encounter
  end

  def reset
    reset_session
    respond_to do |format|
      format.js { render inline: 'location.reload();' }
    end
  end

  private

  def counter
    session[:counter] ||= 0
    session[:players] ||= []
    session[:monsters] ||= []
    @counter = session[:counter]
    @players = session[:players]
    @monsters = session[:monsters]
    @dto = self.encounter
  end

  def encounter
    @encounter = Encounter.new

    # add all players to the party
    session[:players]
      # .map { |p| PlayerCharacter.new(OpenStruct.new(p)) }
      .map { |p| PlayerCharacter.new(p) }
      .each { |p| @encounter.party.join(p) }

    # add all monsters
    session[:monsters]
      # .map { |m| Monster.new(OpenStruct.new(m)) }
      .map { |m| Monster.new(m) }
      .each { |m| @encounter.add_monster(m) }

    # calculate the difficulty
    @dto = @encounter.calculate_difficulty

    # debugger

    @dto
  end

end
