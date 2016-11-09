require 'rails_helper'

describe "Create a season week entry" do
  it "from the nfl fantasy API" do
    VCR.use_cassette("season_week_via_api") do
      expect(SeasonWeek.count).to eq(0)

      FantasyAPIService.by_season_week({week: 9, season: "2015", position: "QB"})

      expect(SeasonWeek.count).to eq(1)
      expect(SeasonWeek.last.week).to eq(9)
      expect(SeasonWeek.last.season).to eq(2015)
    end
  end
end
