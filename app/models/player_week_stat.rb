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

  def player_name
    player.name
  end

  def self.by_position(position)
    ActiveRecord::Base.connection.exec_query(by_position_sql)
  end



  private
    def self.get_stats_names
      stat_names = attribute_names - ["id", "player_id", "season_week_id", "created_at", "updated_at"]
    end

    def self.by_position_sql
      'SELECT "player_week_stats".* FROM player_week_stats INNER JOIN players ON players.id = player_week_stats.player_id'
    end
end
