weeks = (1..17)
seasons = (2009..2016)
positions = ["QB", "RB", "WR", "TE"]
seasons.each do |season|
  weeks.each do |week|
    positions.each do |position|
      FantasyAPIService.by_season_week({week: week, season: season, position: position})
      puts "#{position}s for week #{week} in season #{season} added"
    end
  end
end
