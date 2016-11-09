class StoredNeuralNet < ApplicationRecord
  def revive_net
    nn = NeuralNet.new(*layer_sizes)
    weights_matrix = weights.map do |weight_layer|
      Matrix.rows(weight_layer)
    end
    biases_matrix = biases.map do |bias_layer|
      Matrix.rows(bias_layer)
    end
    nn.weights = weights_matrix
    nn.biases = biases_matrix
    nn
  end
end
