class FantasyAPIService
  def self.by_season_week(season_week_params)
    week = season_week_params[:week]
    season = season_week_params[:season]
    position = season_week_params[:position]
    response = Faraday.get("http://api.fantasy.nfl.com/v1/players/stats?statType=weekStats&week=#{week}&season=#{season}&position=#{position}&format=json")
    data = JSON.parse(response.body, symbolize_names: true)

    season_week = SeasonWeek.find_or_create_by(week: week, season: season)

    data[:players].map do |raw_player|
      name = raw_player[:name]
      current_team = raw_player[:teamAbbr]
      position = raw_player[:position]
      stats = format_stats(raw_player[:stats])
      player = Player.find_or_create_by(name: name, current_team: current_team, position: position)
      player.player_week_stats.create(stats.merge(season_week: season_week))
    end
  end

  def self.format_stats(raw_stats)
    raw_stats.map do |stat_number, stat|
      # raw_stats.key(stat) = stats_hash[stat_number]
      stat_name = stats_hash[stat_number]
      if stat_name
        [stats_hash[stat_number], stat]
      end
    end.compact.to_h
  end

  private
    def self.stats_hash
      {
        :"2" => :pass_att,
        :"3" => :pass_comp,
        :"5" => :pass_yds,
        :"6" => :pass_td,
        :"7" => :pass_int,
        :"8" => :sacked,
        :"13" => :rush_att,
        :"14" => :rush_yds,
        :"15" => :rush_td,
        :"20" => :rec_made,
        :"21" => :rec_yds,
        :"22" => :rec_td
      }
    end
end
