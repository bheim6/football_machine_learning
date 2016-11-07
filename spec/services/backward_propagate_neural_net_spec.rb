require 'rails_helper'

describe 'Neural Net backward propagation' do
  it 'given training data' do
    nn = NeuralNet.new(2, 1)

    nn.initial_activation = [0.5, 0.8]

    nn.learning_rate = 0.02

    nn.weights[1] = Matrix[[0.3], [1]]
    nn.biases[1] = Matrix[[0.1]]

    nn.forward_propagate

    correct_values = [0.9]

    nn.backward_propagate(correct_values)

    change_in_biases = (nn.biases.last[0,0] - 0.1)

    delta_results = nn.delta.map do |matrix|
      matrix.map do |element|
        element.round(5)
      end
    end

    weights_results = nn.weights.map do |matrix|
      matrix.map do |element|
        element.round(9)
      end
    end

    expected_delta = [Matrix[[0.0, 0.0]], Matrix[[-0.03058]]]
    expected_weights = [Matrix.zero(1), Matrix[[0.300305756], [1.000489209]]]

    expect(delta_results).to eq(expected_delta)
    expect(change_in_biases.round(9)).to eq(0.000611512)
    expect(weights_results).to eq(expected_weights)
  end
end
