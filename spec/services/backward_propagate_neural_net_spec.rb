require 'rails_helper'

describe 'Neural Net backward propagation' do
  context 'for simplest neural net' do
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

  context 'for multi output node neural net' do
    it 'given training data' do
      nn = NeuralNet.new(2,2)

      nn.initial_activation = [0.5, 0.8]

      nn.learning_rate = 0.02

      nn.weights[1] = Matrix[[0.3, 0.5], [1, 0.2]]
      nn.biases[1] = Matrix[[0.1, 0.2]]

      nn.forward_propagate

      correct_values = [0.9, 0.7]

      nn.backward_propagate(correct_values)

      biases_results = nn.biases.map do |matrix|
        matrix.map do |element|
          element.round(9)
        end
      end

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

      expected_delta = [Matrix[[0.0, 0.0]], Matrix[[-0.03058, -0.01188]]]
      expected_weights = [Matrix.zero(1), Matrix[[0.300305756, 0.500118754], [1.000489209, 0.200190007]]]
      expected_biases = [Matrix.zero(1), Matrix[[0.100611512, 0.200237508]]]

      expect(delta_results).to eq(expected_delta)
      expect(biases_results).to eq(expected_biases)
      expect(weights_results).to eq(expected_weights)
    end
  end

  context 'for net with hidden layer' do
    it 'given training data' do
      nn = NeuralNet.new(1,2,2)

      nn.initial_activation = [0.5]

      nn.learning_rate = 0.02

      nn.weights[1] = Matrix[[0.3, 0.5]]
      nn.weights[2] = Matrix[[0.2, 0.4], [0.6, 0.8]]
      nn.biases[1] = Matrix[[0.1, 0.2]]
      nn.biases[2] = Matrix[[0.3, 0.4]]

      nn.forward_propagate

      correct_values = [0.9, 0.7]

      nn.backward_propagate(correct_values)

      biases_results = nn.biases.map do |matrix|
        matrix.map do |element|
          element.round(7)
        end
      end

      delta_results = nn.delta.map do |matrix|
        matrix.map do |element|
          element.round(5)
        end
      end

      weights_results = nn.weights.map do |matrix|
        matrix.map do |element|
          element.round(7)
        end
      end

      expected_delta = [Matrix[[0.0]], Matrix[[-0.00132, -0.00474]], Matrix[[-0.04627, 0.00982]]]
      expected_weights = [Matrix[[0.0]], Matrix[[(0.3 + 0.0000132), (0.5 + 0.0000474)]], Matrix[[0.2005202, 0.3998896], [(0.6 + 0.000565), 0.7998801]]]
      expected_biases = [Matrix[[0.0]], Matrix[[0.1000263, 0.2000948]], Matrix[[0.3009253, 0.3998036]]]

      expect(delta_results).to eq(expected_delta)
      expect(biases_results).to eq(expected_biases)
      expect(weights_results).to eq(expected_weights)
    end
  end
end
