require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should have_many :player_week_stats }
end
