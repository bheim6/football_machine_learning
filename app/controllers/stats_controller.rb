class StatsController < ApplicationController
  def index
    @player_week_stats = PlayerWeekStat.joins('INNER JOIN players ON player_week_stats.player_id = players.id')
    @stat_names = PlayerWeekStat.stat_names_for_header
    @raw_stat_names = PlayerWeekStat.stat_names
  end
end
