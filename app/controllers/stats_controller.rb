class StatsController < ApplicationController
  def index
    # require "pry"; binding.pry
    # @player_week_stats = PlayerWeekStat.joins('INNER JOIN players ON player_week_stats.player_id = players.id')
    @player_week_stats = Player.joins(:player_week_stats).select('player_week_stats.*, players.name').where(position: "QB")
    @stat_names = PlayerWeekStat.stat_names_for_header
    @raw_stat_names = PlayerWeekStat.stat_names
  end
end
