class FantasyAPIService
  def self.by_season_week(season_week_params)
    week = season_week_params[:week]
    season = season_week_params[:season]
    position = season_week_params[:position]
    response = Faraday.get("http://api.fantasy.nfl.com/v1/players/stats?statType=weekStats&week=#{week}&season=#{season}&position=#{position}&format=json")
  end
end
