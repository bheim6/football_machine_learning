class DataPrepService
  def initialize(season_week, player)
    @season_week = season_week
    @player = player
  end

  def self.week_prediction_array(season_week, player)
    data_prep = DataPrepService.new(season_week, player)
    if data_prep.previous_game_count < 4
      raise ArgumentError, 'Not enough games prior to given Season Week to calculate prediction'
    else
      data_prep.get_last_four_games
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

  private
    attr_reader :season_week, :player
end
