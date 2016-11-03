require 'rails_helper'

RSpec.describe PlayerWeekStat, type: :model do
  it { should belong_to :player }
  it { should belong_to :season_week }
end
