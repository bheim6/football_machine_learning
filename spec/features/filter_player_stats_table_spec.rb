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

  # it "shows a list of players and their statistics based on week" do
  #
  # end
  #
  # it "shows a list of players and their statistics based on year" do
  #
  # end
end
