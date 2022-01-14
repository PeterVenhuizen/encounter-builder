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
      session[:players].delete_if { |h| h['uuid'] == params[:uuid] }
    else
      session[:players] << { name: params[:name],
                             level: params[:level],
                             uuid: SecureRandom.uuid }
    end

    encounter
    # render partial :player
    # render partial :encounter
  end

  def monster
    if params.key?('uuid')
      session[:monsters].delete_if { |h| h['uuid'] == params[:uuid] }
    else
      puts params
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
    puts 'test'
    @encounter = Encounter.new

    # add all players to the party
    session[:players]
      .map { |p| PlayerCharacter.new(OpenStruct.new(p)) }
      .each { |p| @encounter.party.join(p) }

    puts @encounter.party.inspect

    # add all monsters
    session[:monsters]
      .map { |m| Monster.new(OpenStruct.new(m)) }
      .each { |m| @encounter.add_monster(m) }

    puts @encounter.monsters

    # calculate the difficulty
    @dto = @encounter.calculate_difficulty

    # debugger

    @dto
  end

end
