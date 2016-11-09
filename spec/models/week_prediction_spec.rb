require 'rails_helper'

RSpec.describe WeekPrediction, type: :model do
  context "associations" do
    it { should belong_to :player }
    it { should belong_to :season_week }
  end

  it "can be created from a stat array" do
    nn = NeuralNet.new(48,30,12)
    player = create(:player)
    season_week = create(:season_week)

    expect(WeekPrediction.count).to eq(0)
    WeekPrediction.from_neural_net_results(nn.results, season_week, player)
    expect(WeekPrediction.count).to eq(1)
  end
end
