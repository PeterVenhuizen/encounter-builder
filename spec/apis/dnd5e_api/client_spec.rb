require 'rails_helper'
require 'vcr_setup'

RSpec.describe Dnd5eAPI::Client do
  describe "monster_by_name" do
    let(:client) { Dnd5eAPI::Client.new }

    it "transform the search term to lowercase" do
      prepared_search_term = client.prepare_search_term("Bandit")
      expect(prepared_search_term).to eq "bandit"
    end

    it "replaces spaces by dashes in the search term", :vcr do
      prepared_search_term = client.prepare_search_term("Adult Black Dragon")
      expect(prepared_search_term).to eq "adult-black-dragon"
      response = client.monster_by_name("Adult Black Dragon")
      expect(response.ok?).to be true
    end

    it "returns error not found for an unknown monster", :vcr do
      response = client.monster_by_name('skdjfiwej')
      expect(response.ok?).to be false
      expect(response.body).to eq({ error: 'Not found' })
    end

    describe "successful requests", :vcr do
      let(:response) { client.monster_by_name("bandit") }

      it "has an index, url and name" do
        expect(response.ok?).to be true
        expect(response.body).to have_key(:index)
        expect(response.body).to have_key(:name)
        expect(response.body).to have_key(:url)
      end

      it "the challenge ratings with a fraction are transformed to rationals" do
        expect(response.data[:challenge_rating]).to eq '1/8'
      end
    end
  end

  describe "monsters_by_challenge_rating" do
    let(:client) { Dnd5eAPI::Client.new }

    describe "successful requests", :vcr do
      let(:response) { client.monsters_by_challenge_rating(["1"]) }

      it "request by challenge rating has a count and results" do
        expect(response.body).to have_key(:count)
        expect(response.body).to have_key(:results)
      end

      it "each has an index, url and name" do
        response.body[:results].each do |result|
          expect(result).to have_key(:index)
          expect(result).to have_key(:name)
          expect(result).to have_key(:url)
        end
      end
    end
  end
end
