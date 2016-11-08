require 'rails_helper'

RSpec.describe "DataPrepService" do
  it "Returns an array of 4 sequential weeks of statistics for a single player" do
    dc = create(:player, name: "Derek Carr", position: "QB")
    season_week1 = create(:season_week, season: 2015, week: 1)
    season_week2 = create(:season_week, season: 2015, week: 2)
    season_week3 = create(:season_week, season: 2015, week: 3)
    season_week4 = create(:season_week, season: 2015, week: 4)
    season_week5 = create(:season_week, season: 2015, week: 5)
    player_week_stat1 = create(:player_week_stat, season_week: season_week1, player: dc)
    player_week_stat2 = create(:player_week_stat, season_week: season_week2, player: dc)
    player_week_stat3 = create(:player_week_stat, season_week: season_week3, player: dc)
    player_week_stat4 = create(:player_week_stat, season_week: season_week4, player: dc)


    stats_array = DataPrepService.last_four_games(season_week5, dc)

    expected_stats_array = [
      [8,2,0,0,0,0,40,25,289,3,1,2],
      [8,2,0,0,0,0,40,25,289,3,1,2],
      [8,2,0,0,0,0,40,25,289,3,1,2],
      [8,2,0,0,0,0,40,25,289,3,1,2]
    ]

    expect(stats_array).to eq(expected_stats_array)
  end

  it "Returns 4 weeks regardless if they are back-to-back weeks" do
    dc = create(:player, name: "Derek Carr", position: "QB")
    season_week1 = create(:season_week, season: 2015, week: 1)
    season_week2 = create(:season_week, season: 2015, week: 2)
    season_week3 = create(:season_week, season: 2015, week: 3)
    season_week5 = create(:season_week, season: 2015, week: 5)
    season_week7 = create(:season_week, season: 2015, week: 7)
    player_week_stat1 = create(:player_week_stat, season_week: season_week1, player: dc)
    player_week_stat2 = create(:player_week_stat, season_week: season_week2, player: dc)
    player_week_stat3 = create(:player_week_stat, season_week: season_week3, player: dc)
    player_week_stat5 = create(:player_week_stat, season_week: season_week5, player: dc)


    stats_array = DataPrepService.last_four_games(season_week7, dc)

    expected_stats_array = [
      [8,2,0,0,0,0,40,25,289,3,1,2],
      [8,2,0,0,0,0,40,25,289,3,1,2],
      [8,2,0,0,0,0,40,25,289,3,1,2],
      [8,2,0,0,0,0,40,25,289,3,1,2]
    ]
    #
    expect(stats_array).to eq(expected_stats_array)
  end

  it "Returns weeks from previous seasons when predicting early weeks" do
    dc = create(:player, name: "Derek Carr", position: "QB")
    season_week16 = create(:season_week, season: 2014, week: 16)
    season_week2 = create(:season_week, season: 2015, week: 2)
    season_week3 = create(:season_week, season: 2015, week: 3)
    season_week5 = create(:season_week, season: 2015, week: 5)
    season_week7 = create(:season_week, season: 2015, week: 7)
    player_week_stat16 = create(:player_week_stat, season_week: season_week16, player: dc)
    player_week_stat2 = create(:player_week_stat, season_week: season_week2, player: dc)
    player_week_stat3 = create(:player_week_stat, season_week: season_week3, player: dc)
    player_week_stat5 = create(:player_week_stat, season_week: season_week5, player: dc)


    stats_array = DataPrepService.last_four_games(season_week7, dc)

    expected_stats_array = [
      [8,2,0,0,0,0,40,25,289,3,1,2],
      [8,2,0,0,0,0,40,25,289,3,1,2],
      [8,2,0,0,0,0,40,25,289,3,1,2],
      [8,2,0,0,0,0,40,25,289,3,1,2]
    ]

    expect(stats_array).to eq(expected_stats_array)
  end

  it "Returns an error message if 4 weeks aren't available" do
    dc = create(:player, name: "Derek Carr", position: "QB")
    pm = create(:player)
    season_week2 = create(:season_week, season: 2015, week: 2)
    season_week3 = create(:season_week, season: 2015, week: 3)
    season_week4 = create(:season_week, season: 2015, week: 4)
    season_week5 = create(:season_week, season: 2015, week: 5)
    player_week_stat2 = create(:player_week_stat, season_week: season_week2, player: dc)
    player_week_stat3 = create(:player_week_stat, season_week: season_week3, player: dc)
    player_week_stat4 = create(:player_week_stat, season_week: season_week4, player: dc)
    different_player_week_stat = create(:player_week_stat, season_week: season_week4, player: pm)

    expect{DataPrepService.last_four_games(season_week5, dc)}.to raise_error(ArgumentError, 'Not enough games prior to given Season Week to calculate prediction')
  end

  it "returns a normalized array of statistics" do
    dc = create(:player, name: "Derek Carr", position: "QB")
    season_week1 = create(:season_week, season: 2015, week: 1)
    season_week2 = create(:season_week, season: 2015, week: 2)
    season_week3 = create(:season_week, season: 2015, week: 3)
    season_week4 = create(:season_week, season: 2015, week: 4)
    season_week5 = create(:season_week, season: 2015, week: 5)
    player_week_stat1 = create(:player_week_stat, season_week: season_week1, player: dc)
    player_week_stat2 = create(:player_week_stat, season_week: season_week2, player: dc)
    player_week_stat3 = create(:player_week_stat, season_week: season_week3, player: dc)
    player_week_stat4 = create(:player_week_stat, season_week: season_week4, player: dc)

    expected_stats_array = [
      [0.022857142857142857, 0.03333333333333333,0.0,0.0,0.0,0.0,0.5,0.3125,0.3853333333333333,0.3,0.1,0.1],
      [0.022857142857142857, 0.03333333333333333,0.0,0.0,0.0,0.0,0.5,0.3125,0.3853333333333333,0.3,0.1,0.1],
      [0.022857142857142857, 0.03333333333333333,0.0,0.0,0.0,0.0,0.5,0.3125,0.3853333333333333,0.3,0.1,0.1],
      [0.022857142857142857, 0.03333333333333333,0.0,0.0,0.0,0.0,0.5,0.3125,0.3853333333333333,0.3,0.1,0.1]
    ]
    normalized = DataPrepService.last_four_normalized_games(season_week5, dc)

    normalized.map! do |week|
      week.map! do |normalized_stat|
        normalized_stat.to_f
      end
    end

    expect(normalized).to eq(expected_stats_array)
  end
end
