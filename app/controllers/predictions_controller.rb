class PredictionsController < ApplicationController
  def index
    nn = StoredNeuralNet.last.revive_net

    season_week = SeasonWeek.last

    player = Player.find_by(name: "Derek Carr")

    nn.initial_activation = DataPrepService.last_four_normalized_games(season_week, player).flatten

    nn.forward_propagate
    @player = player
    @results = DataPrepService.denormalize_stats(nn.results).map { |e| e.to_f }.to_a[0]
  end
end
