module Dnd5eAPI
  class Client
    API_ENDPOINT = 'https://www.dnd5eapi.co/api/'.freeze

    def monster_by_name(name)
      request(
        endpoint: "monsters/#{name}"
      )
    end

    def monsters_by_challenge_rating(challenge_rating)
      request(
        endpoint: "monsters?challenge_rating=#{challenge_rating.join(',')}"
      )
    end

    private

    def client
      @_client ||= Faraday.new(API_ENDPOINT) do |client|
        client.request :url_encoded
        client.adapter Faraday.default_adapter
      end
    end

    def request(endpoint:, params: {})
      response = client.public_send(:get, endpoint, params)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
