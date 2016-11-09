require 'rails_helper'

describe 'Neural net forward propagation' do
  it 'propagates values to end' do
    nn = NeuralNet.new(2, 1)

    nn.initial_activation = [0.5, 0.8]

    # setting weights, biases manually for testing,
    # usually weights are random
    nn.weights[1] = Matrix[[0.3], [1]]
    nn.biases[1] = Matrix[[0.1]]

    nn.forward_propagate

    expected_value = 0.74077

    calculated_ending_value = nn.activations.last[0,0].round(5)

    expect(calculated_ending_value).to eq(expected_value)
  end

  it 'propagates a batch of values to end' do
    nn = NeuralNet.new(2, 1)

    nn.initial_activation = [0.5, 0.8], [0.3, 0.4]

    # setting weights, biases manually for testing,
    # usually weights are random
    nn.weights[1] = Matrix[[0.3], [1]]
    nn.biases[1] = Matrix[[0.1], [0.1]]
    nn.forward_propagate

    expected_matrix = Matrix[[0.74077], [0.64337]]

    result_matrix = nn.activations.last.map { |e| e.round(5) }

    expect(result_matrix).to eq(expected_matrix)
  end
end
