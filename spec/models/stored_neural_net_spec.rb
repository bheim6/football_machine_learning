require 'rails_helper'

RSpec.describe StoredNeuralNet, type: :model do
  it "stores a net's values" do
    nn = NeuralNet.new(3,1,2)
    nn.weights = nn.weights.map { |layer| layer.map { |e| BigDecimal.new(e,10) } }
    nn.biases = nn.biases.map { |layer| layer.map { |e| BigDecimal.new(e,10) } }

    weights_array = nn.weights.map do |weight_layer|
      weight_layer.to_a
    end

    biases_array = nn.biases.map do |bias_layer|
      bias_layer.to_a
    end
    stored_net = StoredNeuralNet.new(weights: weights_array, biases: biases_array, layer_sizes: nn.layer_sizes)

    expect(stored_net.weights).to eq(weights_array)
    expect(stored_net.biases).to eq(biases_array)
    expect(stored_net.layer_sizes).to eq(nn.layer_sizes)
  end

  it "retrieves a net's values" do
    nn = NeuralNet.new(3,1,2)
    nn.weights = nn.weights.map { |layer| layer.map { |e| BigDecimal.new(e,10) } }
    nn.biases = nn.biases.map { |layer| layer.map { |e| BigDecimal.new(e,10) } }

    weights_array = nn.weights.map do |weight_layer|
      weight_layer.to_a
    end

    biases_array = nn.biases.map do |bias_layer|
      bias_layer.to_a
    end

    stored_net = StoredNeuralNet.new(weights: weights_array, biases: biases_array, layer_sizes: nn.layer_sizes)

    revived_net = stored_net.revive_net

    expect(revived_net.weights).to eq(nn.weights)
    expect(revived_net.biases).to eq(nn.biases)
  end
end
