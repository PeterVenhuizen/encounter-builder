class MonstersSearchController < ApplicationController
  layout false

  def index
    @encounter = Encounter.new
    @monsters = params[:search].empty? ? [] : Monster.where('lower(name) LIKE ?', "%#{params[:search]}%")
  end
end
