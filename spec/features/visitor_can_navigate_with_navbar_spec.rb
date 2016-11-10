require 'rails_helper'

RSpec.feature "Visitor can visit" do
  it "stats page using navbar" do
    visit '/'

    within('.navbar') do
      click_link "Stats"
    end

    expect(current_path).to eq(stats_path)
  end

  it "predictions page using navbar" do
    StoredNeuralNet.create
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

    visit '/'

    within('.navbar') do
      click_link "Predictions"
    end

    expect(current_path).to eq(predictions_path)
  end

  it "blog page using navbar" do
    visit '/'

    within('.navbar') do
      click_link "Blog"
    end

    expect(current_path).to eq('/blog')
  end
end
