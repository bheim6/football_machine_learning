class SeasonWeek < ApplicationRecord
  has_many :player_week_stats
  has_many :players, through: :player_week_stats
end
