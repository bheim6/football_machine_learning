class SeasonWeek < ApplicationRecord
  has_many :player_week_stats, optional: true
  has_many :players, through: :player_week_stats, optional: true
end
