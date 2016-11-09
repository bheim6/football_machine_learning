class StoredNeuralNet < ApplicationRecord
  def revive_net
    nn = NeuralNet.new(*layer_sizes)
    # weights_matrix = weights.map do |weight_layer|
    #   Matrix.rows(weight_layer)
    # end
    # biases_matrix = biases.map do |bias_layer|
    #   Matrix.rows(bias_layer)
    # end

    nn.weights[0] = Matrix.rows(first_weights)
    nn.weights[1] = Matrix.rows(hidden_weights)
    nn.weights[2] = Matrix.rows(last_weights)
    nn.biases[0] = Matrix.rows(first_biases)
    nn.biases[1] = Matrix.rows(hidden_biases)
    nn.biases[2] = Matrix.rows(last_biases)
    nn
  end

  def self.store(neural_net)
    weights_array = neural_net.weights.map do |weight_layer|
      weight_layer.to_a
    end
    biases_array = neural_net.biases.map do |bias_layer|
      bias_layer.to_a
    end

    StoredNeuralNet.create(
      first_weights: weights_array[0],
      hidden_weights: weights_array[1],
      last_weights: weights_array[2],
      first_biases: biases_array[0],
      hidden_biases: biases_array[1],
      last_biases: biases_array[2],
      layer_sizes: neural_net.layer_sizes
    )
  end
end
