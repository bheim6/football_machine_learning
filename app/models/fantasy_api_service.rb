class FantasyAPIService
  def self.by_season_week(season_week_params)
    week = season_week_params[:week]
    season = season_week_params[:season]
    position = season_week_params[:position]
    response = Faraday.get("http://api.fantasy.nfl.com/v1/players/stats?statType=weekStats&week=#{week}&season=#{season}&position=#{position}&format=json")
    data = JSON.parse(response.body, symbolize_names: true)
    data[:players].map do |raw_player|
      name = raw_player[:name]
      current_team = raw_player[:teamAbbr]
      position = raw_player[:position]
      Player.find_or_create_by(name: name, current_team: current_team, position: position)
    end
  end
end
