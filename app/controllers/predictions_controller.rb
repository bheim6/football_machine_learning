class PredictionsController < ApplicationController
  def index
    nn = StoredNeuralNet.last.revive_net

    @season_week = SeasonWeek.find_by(season: 2016, week: 10)

    players = @season_week.players

    @player_predictions = players.map do |player|
      data = DataPrepService.last_four_normalized_games(@season_week, player).flatten
      nn.initial_activation = data
      nn.forward_propagate
      WeekPrediction.from_neural_net_results(nn.results, @season_week, player)
    end
  end
end
