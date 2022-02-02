class EncountersController < ApplicationController
  before_action :set_encounter, only: %i[show edit update destroy]
  protect_from_forgery with: :null_session, only: %i[calculate_party_stats calculate_stats]

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

  def calculate_stats
    # puts params
    # debugger

    # get the party
    party = Party.where(id: params[:party_id]).first

    # Get rid of "empty" monsters
    params[:monsters].filter! { |m| m unless m[:id].empty? }

    # get the monster objects
    monsters = params[:monsters]
      .flat_map { |m| m[:group_size].to_i.times.collect { Monster.where(id: m[:id]).first } }

    # return default json if no party or monsters
    if party.nil? || monsters.empty?
      return render json: {
        multiplier: 1,
        difficulty: :none,
        total_experience: 0,
        adjusted_experience: 0
      }
    end

    # calculate the multiplier
    multiplier = calc_multiplier(monsters.count, party)

    # total experience
    total_experience = monsters.sum(&:xp)

    # adjusted experience
    adjusted_experience = total_experience * multiplier

    # difficulty
    difficulty = calc_difficulty(party, adjusted_experience)

    render json: {
      multiplier: multiplier,
      difficulty: difficulty,
      total_experience: total_experience,
      adjusted_experience: adjusted_experience
    }
  end

  def fetch_monster(id)
    @monster = Monster.find(id)
  end
  helper_method :fetch_monster

  def search
    @encounter = Encounter.new
    @monsters = params[:search].empty? ? [] : Monster.where("lower(name) LIKE ?",  "%#{params[:search]}%")
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

  def calc_multiplier(number_of_monsters, party)
    multipliers = [0.5, 1, 1.5, 2, 2.5, 3, 4, 5]

    case number_of_monsters
    when 0..1 then idx = 1
    when 2 then idx = 2
    when 3..6 then idx = 3
    when 7..10 then idx = 4
    when 11..14 then idx = 5
    else idx = 6
    end

    # small party makes it a harder encounter
    idx += 1 if (1..2).include?(party.party_size)

    # big party makes an encounter easier
    idx -= 1 if party.party_size >= 6

    multipliers[idx]
  end

  def calc_difficulty(party, adjusted_experience)
    difficulties = %i[trivial easy medium hard deadly]
    idx = party.party_xp.values.count { |v| adjusted_experience >= v }
    difficulties[idx]
  end
end
