class MonstersSearchController < ApplicationController
  layout false

  def index
    @encounter = Encounter.new
    @monsters = params[:search].empty? ? [] : Monster.where("lower(name) LIKE ?",  "%#{params[:search]}%")
  end

  def fetch_monster(id)
    @monster = Monster.find(id)
  end
  helper_method :fetch_monster
end
