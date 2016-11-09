require 'rails_helper'

describe "Create a player week stats entry" do
  it "from the nfl fantasy API" do
    VCR.use_cassette("season_week_via_api") do
      expect(PlayerWeekStat.count).to eq(0)

      FantasyAPIService.by_season_week({week: 9, season: "2015", position: "QB"})

      first_player_stats = PlayerWeekStat.first
      expect(PlayerWeekStat.count).to eq(31)
      expect(first_player_stats.player.name).to eq("Blake Bortles")
      expect(first_player_stats.pass_att).to eq(40)
      expect(first_player_stats.pass_comp).to eq(24)
      expect(first_player_stats.pass_yds).to eq(381)
      expect(first_player_stats.pass_td).to eq(2)
      expect(first_player_stats.pass_int).to eq(2)
      expect(first_player_stats.sacked).to eq(6)
      expect(first_player_stats.rush_att).to eq(4)
      expect(first_player_stats.rush_yds).to eq(32)
      expect(first_player_stats.rush_td).to eq(0)
      expect(first_player_stats.rec_made).to eq(0)
      expect(first_player_stats.rec_yds).to eq(0)
      expect(first_player_stats.rec_td).to eq(0)
    end
  end
end
