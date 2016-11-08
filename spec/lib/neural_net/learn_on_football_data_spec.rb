require 'rails_helper'

describe 'Neural Net learns' do
  it 'given football data' do
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
    player_week_stat5 = create(:player_week_stat, season_week: season_week5, player: dc)

    data = DataPrepService.last_four_normalized_games(season_week5, dc)
    answer = DataPrepService.normalize_stats(player_week_stat5.stats_array)
    correct_matrix = Matrix[answer]

    nn = NeuralNet.new(48,30,12)
    error = 0.1
    nn.initial_activation = data.flatten
    nn.learn_within_error(answer,error)

    expect((nn.results - correct_matrix).max).to be_between(-error, error).exclusive
    expect((nn.results - correct_matrix).min).to be_between(-error, error).exclusive
  end

  it 'given a batch of football data' do
    dc = create(:player, name: "Derek Carr", position: "QB")
    pm = create(:player, name: "Peyton Manning", position: "QB")
    season_week1 = create(:season_week, season: 2015, week: 1)
    season_week2 = create(:season_week, season: 2015, week: 2)
    season_week3 = create(:season_week, season: 2015, week: 3)
    season_week4 = create(:season_week, season: 2015, week: 4)
    season_week5 = create(:season_week, season: 2015, week: 5)
    player_1_week_stat1 = create(:player_week_stat, season_week: season_week1, player: dc)
    player_1_week_stat2 = create(:player_week_stat, season_week: season_week2, player: dc)
    player_1_week_stat3 = create(:player_week_stat, season_week: season_week3, player: dc)
    player_1_week_stat4 = create(:player_week_stat, season_week: season_week4, player: dc)
    player_1_week_stat5 = create(:player_week_stat, season_week: season_week5, player: dc)

    player_2_week_stat1 = create(:player_week_stat, season_week: season_week1, player: pm)
    player_2_week_stat2 = create(:player_week_stat, season_week: season_week2, player: pm)
    player_2_week_stat3 = create(:player_week_stat, season_week: season_week3, player: pm)
    player_2_week_stat4 = create(:player_week_stat, season_week: season_week4, player: pm)
    player_2_week_stat5 = create(:player_week_stat, season_week: season_week5, player: pm)

    data_1 = DataPrepService.last_four_normalized_games(season_week5, dc)
    data_2 = DataPrepService.last_four_normalized_games(season_week5, pm)
    data = [data_1.flatten, data_2.flatten]
    answer_1 = DataPrepService.normalize_stats(player_1_week_stat5.stats_array)
    answer_2 = DataPrepService.normalize_stats(player_2_week_stat5.stats_array)
    answer = [answer_1, answer_2]
    correct_matrix = Matrix[answer_1, answer_2]

    nn = NeuralNet.new(48,30,12)
    error = 0.1
    nn.initial_activation = data
    nn.learn_within_error(answer,error)

    expect((nn.results - correct_matrix).max).to be_between(-error, error).exclusive
    expect((nn.results - correct_matrix).min).to be_between(-error, error).exclusive
  end
end
