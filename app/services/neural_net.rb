class NeuralNet
  attr_reader :activations,
              :layer_count,
              :layer_sizes,
              :delta,
              :batch_size

  attr_accessor :weights,
                :biases,
                :learning_rate

  def initialize(*layer_sizes)
    @layer_sizes = layer_sizes
    @layer_count = layer_sizes.count
    @weights = Array.new(layer_count)
    @biases = Array.new(layer_count)
    @activations = Array.new(layer_count)
    @delta = Array.new(layer_count)
    @z_values = Array.new(layer_count)
    @learning_rate = 0.03
    @gen = Rubystats::NormalDistribution.new(0.0, 0.33)
    set_initial_values
  end

  def gaussian_random
    gen.rng
  end

  def initial_activation=(initial_values)
    activations[0] = format_to_matrix(initial_values)
    @batch_size = activations[0].row_count

    layer_count.times do |layer|
      if layer > 0
        activations[layer] = Matrix.zero(batch_size,activations[layer].column_count)
      end
    end
  end

  def initial_activation
    activations.first
  end

  def results
    activations.last
  end

  def forward_propagate
    layer_count.times do |layer|
      if layer > 0
        result = Matrix.zero(0,biases[layer].column_count)
        weighted_activations = activations[layer - 1] * weights[layer]
        z_values[layer] = weighted_activations.row_vectors.inject(result) do |result, vector|
          z_vector = vector + biases[layer].row(0)
          result = result.vstack(Matrix[z_vector])
          result
        end
        activations[layer] = sigmoid_matrix(z_values[layer])
      end
    end
  end

  def learning_cycle(correct_values)
    forward_propagate
    backward_propagate(correct_values)
  end

  def learn_within_error(correct_values, error)
    current_error = 1
    correct_matrix = format_to_matrix(correct_values)
    while current_error > error do
      learning_cycle(correct_values)
      current_error = (results - correct_matrix).max
      min = (results - correct_matrix).min
      current_error = min.abs if min.abs > current_error
    end
  end

  def backward_propagate(correct_values)
    correct_matrix = format_to_matrix(correct_values)
    (layer_count - 1).times do |index|
      if index == 0
        update_last_layer(correct_matrix)
      else
        backwards_layer_index = -(index + 1)
        update_intermediate_layer(backwards_layer_index)
      end
    end
  end


  private
    attr_reader :gen,
                :z_values

    def set_initial_values
      layer_count.times do |layer|
        if layer == 0
          weights[0] = Matrix.zero(1)
          biases[0] = Matrix.zero(1)
        else
          weights[layer] = Matrix.build(layer_sizes[layer - 1], layer_sizes[layer]) { gaussian_random }
          biases[layer] = Matrix.build(1, layer_sizes[layer]) { gaussian_random }
        end
        activations[layer] = Matrix.zero(1, layer_sizes[layer])
        delta[layer] = Matrix.zero(1, layer_sizes[layer])
        z_values[layer] = Matrix.zero(1, layer_sizes[layer])
      end
    end

    def sigmoid_matrix(matrix)
      matrix.map { |element| sigmoid(element) }
    end

    def sigmoid_prime_matrix(matrix)
      matrix.map { |element| sigmoid_prime(element) }
    end

    def sigmoid(value)
      1 / (1 + Math.exp(-1 * value))
    end

    def sigmoid_prime(value)
      sig_value = sigmoid(value)
      sig_value * (1 - sig_value)
    end

    def format_to_matrix(array)
      unless array.first.class == Array
        Matrix[array]
      else
        Matrix.rows(array)
      end
    end

    def row_average(matrix)
      return matrix if matrix.row_count == 1
      result = Matrix.zero(1,matrix.column_count).row_vectors.first
      avg_vector = matrix.row_vectors.inject(result) do |result, vector|
        result + vector
      end / matrix.row_count
      Matrix[avg_vector]
    end

    def resize_delta(delta, batch_size)
      stacked_delta = delta
      (batch_size - 1).times { stacked_delta = stacked_delta.vstack(delta) }
      stacked_delta
    end

    def update_last_layer(correct_matrix)
      avg_z_values = row_average(z_values.last)
      avg_cost_gradient = row_average(activations.last - correct_matrix)
      delta[-1] = avg_cost_gradient.hadamard(sigmoid_prime_matrix(avg_z_values))
      biases[-1] -= learning_rate * delta[-1]
      resized_delta = resize_delta(delta[-1], batch_size)
      weights[-1] -= learning_rate * (activations[-2].transpose * resized_delta)
    end

    def update_intermediate_layer(backwards_layer_index)
      avg_z_values = row_average(z_values[backwards_layer_index])
      delta[backwards_layer_index] =
        (delta[backwards_layer_index + 1] * weights[backwards_layer_index + 1].transpose)
        .hadamard(sigmoid_prime_matrix(avg_z_values))

      biases[backwards_layer_index] -= learning_rate * delta[backwards_layer_index]
      resized_delta = resize_delta(delta[backwards_layer_index], batch_size)
      weights[backwards_layer_index] -= learning_rate * (activations[backwards_layer_index - 1].transpose * resized_delta)
    end
end
