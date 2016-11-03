class PlayerWeekStat < ApplicationRecord
  belongs_to :player
  belongs_to :season_week
end
