FactoryGirl.define do
  factory :player_week_stat do
    player
    season_week
    rush_yds 8
    rush_att 2
    rush_td 0
    rec_yds 0
    rec_made 0
    rec_td 0
    pass_att 40
    pass_comp 25
    pass_yds 289
    pass_td 3
    pass_int 1
    sacked 2
  end
end
