class StatsController < ApplicationController
  def index
    @player_week_stats = PlayerWeekStat.stats_for_table(position, season, week)

    @stat_names = PlayerWeekStat.stat_names_for_header
    @raw_stat_names = PlayerWeekStat.stat_names
  end

  private
    def position
      if params[:position]
        params[:position]
      else
        "QB"
      end
    end

    def season
      if params[:season]
        params[:season]
      else
        2015
      end
    end

    def week
      if params[:week]
        params[:week]
      else
        1
      end
    end
end
