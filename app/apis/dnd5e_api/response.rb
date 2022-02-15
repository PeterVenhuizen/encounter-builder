module Dnd5eAPI
  class Response
    attr_accessor :body

    def initialize(body)
      @body = body
    end

    def ok?
      @body != { error: 'Not found' }
    end

    def params
      params = @body.deep_dup

      # rename type to species, because type is a reserved database field name
      params[:species] = @body[:type].capitalize

      # change challenge ratings between 0 and 1 to confirm to D&D format
      if @body[:challenge_rating].between?(0.125, 0.5)
        params[:challenge_rating] = @body[:challenge_rating].to_r.to_s
      end

      # ability scores
      abilities = %i[strength dexterity constitution intelligence wisdom charisma]
      params[:ability_scores] = abilities.to_h { |a| [a, @body[a]] }

      { monster: params }
    end
  end
end
