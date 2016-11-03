require 'rails_helper'

describe "Filter Stats Page" do
  it "shows a list of players and their statistics based on position" do
    #Create multiple players with different positions
    rb = create(:player, name: "Terrell Davis", position: "RB")
    create(:player_week_stat, player: rb)
    create(:player_week_stat)

    visit stats_path

    click_button "Running Back"

    within(".stats_table_body") do
      expect(page).to have_content("Terrell Davis")
      expect(page).to_not have_content("Peyton Manning")
    end
  end

  it "shows a list of players and their statistics based on year" do
    tb = create(:player, name: "Tom Brady", position: "QB")
    dc = create(:player, name: "Derek Carr", position: "QB")
    season_1 = create(:season_week, season: 2011, week: 1)
    season_2 = create(:season_week, season: 2009, week: 1)
    create(:player_week_stat, season_week: season_1, player: dc)
    create(:player_week_stat, season_week: season_2, player: tb)

    visit stats_path

    click_button "2011"

    within(".stats_table_body") do
      expect(page).to have_content("Derek Carr")
      expect(page).to_not have_content("Tom Brady")
    end
  end

  it "shows a list of players and their statistics based on week" do
    tb = create(:player, name: "Tom Brady", position: "QB")
    dc = create(:player, name: "Derek Carr", position: "QB")
    season_1 = create(:season_week, season: 2015, week: 1)
    season_2 = create(:season_week, season: 2015, week: 4)
    create(:player_week_stat, season_week: season_1, player: dc)
    create(:player_week_stat, season_week: season_2, player: tb)

    visit stats_path

    within("#week-filter") do
      click_button "4"
    end

    within(".stats_table_body") do
      expect(page).to_not have_content("Derek Carr")
      expect(page).to have_content("Tom Brady")
    end
  end
end
