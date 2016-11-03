require 'rails_helper'

describe "Stats page" do
  it "shows a list of one player with stats in a given season/week/position" do
    create(:player_week_stat)

    visit stats_path

    within(".stats_table_header") do
      expect(page).to have_content("rush yds")
      expect(page).to have_content("rush att")
      expect(page).to have_content("rush td")
      expect(page).to have_content("rec yds")
      expect(page).to have_content("rec made")
      expect(page).to have_content("rec td")
      expect(page).to have_content("pass att")
      expect(page).to have_content("pass comp")
      expect(page).to have_content("pass yds")
      expect(page).to have_content("pass td")
      expect(page).to have_content("int")
      expect(page).to have_content("sacked")
    end

    within(".stats_table_body") do
      expect(page).to have_content(8)
      expect(page).to have_content(2)
      expect(page).to have_content(0)
      expect(page).to have_content(0)
      expect(page).to have_content(0)
      expect(page).to have_content(0)
      expect(page).to have_content(40)
      expect(page).to have_content(25)
      expect(page).to have_content(289)
      expect(page).to have_content(3)
      expect(page).to have_content(1)
      expect(page).to have_content(2)
    end
  end
end
