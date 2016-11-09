require 'rails_helper'

RSpec.feature "Visitor can see Predictions Page" do
  it "with a prediction for a player" do
    dc = create(:player, name: "Derek Carr", position: "QB")
    season_week1 = create(:season_week, season: 2016, week: 6)
    season_week2 = create(:season_week, season: 2016, week: 7)
    season_week3 = create(:season_week, season: 2016, week: 8)
    season_week4 = create(:season_week, season: 2016, week: 9)
    season_week5 = create(:season_week, season: 2016, week: 10)
    player_week_stat1 = create(:player_week_stat, season_week: season_week1, player: dc)
    player_week_stat2 = create(:player_week_stat, season_week: season_week2, player: dc)
    player_week_stat3 = create(:player_week_stat, season_week: season_week3, player: dc)
    player_week_stat4 = create(:player_week_stat, season_week: season_week4, player: dc)
    player_week_stat5 = create(:player_week_stat, season_week: season_week5, player: dc)

    nn = NeuralNet.new(48,30,12)

    nn.initial_activation = DataPrepService.last_four_normalized_games(season_week5, dc).flatten
    answer = DataPrepService.normalize_stats(player_week_stat4.stats_array)
    nn.learn_within_error(answer, 0.2)

    StoredNeuralNet.store(nn)

    visit predictions_path

    expect(page).to have_content("Derek Carr")
    expect(page).to have_content("Passing Yards:")
    expect(page).to have_content("Passing Attempts:")
    expect(page).to have_content("Passing Completions:")
    expect(page).to have_content("Passing Touchdowns:")
    expect(page).to have_content("Interceptions:")
    expect(page).to have_content("Sacked:")
  end
end
