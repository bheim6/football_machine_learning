class WeekPrediction < ApplicationRecord
  belongs_to :player
  belongs_to :season_week

  def self.from_neural_net_results(results, season_week, player)
    denormalized_results = DataPrepService.denormalize_stats(results.round(2)).to_a.first
    create(
      player: player,
      season_week: season_week,
      rush_yds: denormalized_results[0],
      rush_att: denormalized_results[1],
      rush_td: denormalized_results[2],
      rec_yds: denormalized_results[3],
      rec_made: denormalized_results[4],
      rec_td: denormalized_results[5],
      pass_att: denormalized_results[6],
      pass_comp: denormalized_results[7],
      pass_yds: denormalized_results[8],
      pass_td: denormalized_results[9],
      pass_int: denormalized_results[10],
      sacked: denormalized_results[11]
    )
  end
end
