class DataPrepService
  MAX_STATS = [BigDecimal.new(350), BigDecimal.new(60), BigDecimal.new(8), BigDecimal.new(400), BigDecimal.new(25), BigDecimal.new(7), BigDecimal.new(80), BigDecimal.new(80), BigDecimal.new(750), BigDecimal.new(10), BigDecimal.new(10), BigDecimal.new(20)]

  def initialize(season_week, player)
    @season_week = season_week
    @player = player
  end

  def self.last_four_games(season_week, player)
    data_prep = DataPrepService.new(season_week, player)
    if data_prep.previous_game_count < 4
      raise ArgumentError, 'Not enough games prior to given Season Week to calculate prediction'
    else
      data_prep.get_last_four_games
    end
  end

  def self.last_four_normalized_games(season_week, player)
    raw_data = self.last_four_games(season_week, player)
    normalized = raw_data.map do |player_week_stats|
      player_week_stats.map.with_index do |stat_value, i|
        stat_value / MAX_STATS[i]
      end
    end
  end

  def previous_game_count
    PlayerWeekStat.where('player_week_stats.season_week_id < ? AND player_week_stats.player_id = ?', season_week.id, player.id).count
  end

  def get_last_four_games
    i = 1
    stat_array = []
    while stat_array.count < 4
      player_week_stat = PlayerWeekStat.find_by(player_id: player.id, season_week_id: (season_week.id - i))
      stat_array << player_week_stat.stats_array if player_week_stat
      i += 1
    end
    return stat_array
  end

  def self.normalize_stats(stats)
    stats.map.with_index { |stat, i| stat / MAX_STATS[i]}
  end

  def self.denormalize_stats(stats)
    stats.map.with_index { |stat, i| stat * MAX_STATS[i]}
  end

  def self.player_predictions(season_week)
    nn = StoredNeuralNet.last.revive_net
    players = season_week.players
    players.map do |player|
      data = DataPrepService.last_four_normalized_games(season_week, player).flatten
      nn.initial_activation = data
      nn.forward_propagate
      WeekPrediction.from_neural_net_results(nn.results, season_week, player)
    end
  end


  private
    attr_reader :season_week, :player
end
