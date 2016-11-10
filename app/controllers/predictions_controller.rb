class PredictionsController < ApplicationController
  def index
    @season_week = SeasonWeek.find_by(season: 2016, week: 10)
    @player_predictions = DataPrepService.player_predictions(@season_week)
  end
end
