class PlayerWeekStat < ApplicationRecord
  belongs_to :player
  belongs_to :season_week

  def self.stat_names
    stat_names ||= get_stats_names
  end

  private
    def self.get_stats_names
      stat_names = attribute_names - ["id", "player_id", "season_week_id", "created_at", "updated_at"]
      stat_names.map { |stat_name| stat_name.tr("_", " ") }
    end
end
