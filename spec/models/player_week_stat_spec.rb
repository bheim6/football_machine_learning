require 'rails_helper'

RSpec.describe PlayerWeekStat, type: :model do
  context "associations" do
    it { should belong_to :player }
    it { should belong_to :season_week }
  end

  it "has stat name" do
    stat_names = PlayerWeekStat.stat_names_for_header
    expect_stat_names = [
      "rush yds",
      "rush att",
      "rush td",
      "rec yds",
      "rec made",
      "rec td",
      "pass att",
      "pass comp",
      "pass yds",
      "pass td",
      "pass int",
      "sacked"
    ]
    expect(stat_names).to eq(expect_stat_names)
  end

  it "returns an array of stats" do
    player_week_stat = create(:player_week_stat)

    stats_array = player_week_stat.stats_array
    expected_stats_array = [
      8,
      2,
      0,
      0,
      0,
      0,
      40,
      25,
      289,
      3,
      1,
      2
    ]

    expect(stats_array).to eq(expected_stats_array)
  end
end
