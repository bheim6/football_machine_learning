class Player < ApplicationRecord
  has_many :player_week_stats, optional: true
end
