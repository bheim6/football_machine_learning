require 'rails_helper'

describe "Create a player entry" do
  it "from the nfl fantasy API" do
    VCR.use_cassette("create_players_via_api") do
      expect(Player.count).to eq(0)

      FantasyAPIService.by_season_week({week: 2, season: "2015", position: "QB"})

      expect(Player.count).to eq(34)
      expect(Player.first.name).to eq("Blake Bortles")
      expect(Player.first.position).to eq("QB")
      expect(Player.first.current_team).to eq("JAX")
    end
  end
end
