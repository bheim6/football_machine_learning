require 'rails_helper'

RSpec.describe SeasonWeek, type: :model do
  context 'associations' do
    it { should have_many :player_week_stats}
  end
end
