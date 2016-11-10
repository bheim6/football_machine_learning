class PlayerWeekStat < ApplicationRecord
  belongs_to :player
  belongs_to :season_week

  def self.stat_names_for_header
    stat_names ||= get_stats_names
    stat_names.map { |stat_name| stat_name.tr("_", " ") }
  end

  def self.stat_names
    get_stats_names
  end

  def stats_array
    stats = attributes
    stats.delete_if do |stat_name, stat_value|
      stat_name.in?(forbidden_stats)
    end.values
  end

  def self.stats_for_table(position, season, week)
    Player
      .joins(:player_week_stats)
      .select('player_week_stats.*, players.name')
      .where(position: position)
      .joins('INNER JOIN season_weeks ON season_weeks.id = player_week_stats.season_week_id')
      .where('season_weeks.season = ? AND season_weeks.week = ?', season, week)
  end

  private
    def self.get_stats_names
      stat_names = attribute_names - ["id", "player_id", "season_week_id", "created_at", "updated_at"]
    end

    def forbidden_stats
      ["id", "player_id", "season_week_id", "updated_at", "created_at"]
    end
end
