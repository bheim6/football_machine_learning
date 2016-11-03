require 'rails_helper'

RSpec.describe WeekPrediction, type: :model do
  context "associations" do
    it { should belong_to :player }
    it { should belong_to :season_week }
  end
end