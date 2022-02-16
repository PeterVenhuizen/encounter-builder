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
      # response = client.public_send(:get, endpoint, params)
      # Response.new(JSON.parse(response.body, symbolize_names: true))
      body = '{
        "index": "bandit",
        "name": "Bandit",
        "size": "Medium",
        "type": "humanoid",
        "subtype": "any race",
        "alignment": "any non-lawful alignment",
        "armor_class": 12,
        "hit_points": 11,
        "hit_dice": "2d8",
        "speed": {
          "walk": "30 ft."
        },
        "strength": 11,
        "dexterity": 12,
        "constitution": 12,
        "intelligence": 10,
        "wisdom": 10,
        "charisma": 10,
        "proficiencies": [],
        "damage_vulnerabilities": [],
        "damage_resistances": [],
        "damage_immunities": [],
        "condition_immunities": [],
        "senses": {
          "passive_perception": 10
        },
        "languages": "any one language (usually Common)",
        "challenge_rating": 0.125,
        "xp": 25,
        "actions": [
          {
            "name": "Scimitar",
            "desc": "Melee Weapon Attack: +3 to hit, reach 5 ft., one target. Hit: 4 (1d6 + 1) slashing damage.",
            "attack_bonus": 3,
            "damage": [
              {
                "damage_type": {
                  "index": "slashing",
                  "name": "Slashing",
                  "url": "/api/damage-types/slashing"
                },
                "damage_dice": "1d6+1"
              }
            ]
          },
          {
            "name": "Light Crossbow",
            "desc": "Ranged Weapon Attack: +3 to hit, range 80 ft./320 ft., one target. Hit: 5 (1d8 + 1) piercing damage.",
            "attack_bonus": 3,
            "damage": [
              {
                "damage_type": {
                  "index": "piercing",
                  "name": "Piercing",
                  "url": "/api/damage-types/piercing"
                },
                "damage_dice": "1d8+1"
              }
            ]
          }
        ],
        "url": "/api/monsters/bandit"
      }'
      # body = '{ "error": "Not found" }'
      Response.new(JSON.parse(body, symbolize_names: true))
    end
  end
end
