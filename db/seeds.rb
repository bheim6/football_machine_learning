weeks = (1..16)
seasons = (2009..2015)
seasons.each do |season|
  weeks.each do |week|
    FantasyAPIService.by_season_week({week: week, season: season, position: "QB"})
    puts "week #{week} in season #{season} added"
  end
end
