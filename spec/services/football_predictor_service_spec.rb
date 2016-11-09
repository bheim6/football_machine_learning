require 'rails_helper'

describe 'Football Predictor Service' do
  it 'learns for one epochs' do
    weeks = (1..8)
    season = 2014
    position = "QB"

    weeks.each do |week|
      VCR.use_cassette("stats_in_week_#{week}") do
        FantasyAPIService.by_season_week(week: week, season: season, position: position)
      end
    end

    predictor = FootballPredictorService.new(epoch: 2, error: 0.5)
    predictor.learn

    # require "pry"; binding.pry
  end
end
