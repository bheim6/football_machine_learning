class NeuralNet
  attr_reader :activations,
              :layer_count,
              :layer_sizes,
              :delta

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
    batch_size = activations[0].row_count

    layer_count.times do |layer|
      if layer > 0
        activations[layer] = Matrix.zero(batch_size,activations[layer].column_count)
        old_biases = biases[layer]
        until biases[layer].row_count == activations[layer].row_count
          biases[layer] = biases[layer].vstack(old_biases)
        end
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
        z_values[layer] = activations[layer - 1] * weights[layer] + biases[layer]
        activations[layer] = sigmoid_matrix(z_values[layer])
      end
    end
  end

  def learn_within_error(correct_values, error)
    current_error = 1
    correct_matrix = format_to_matrix(correct_values)
    while current_error > error do
      forward_propagate
      backward_propagate(correct_values)
      current_error = (results - correct_matrix).max
      min = (results - correct_matrix).min
      current_error = min.abs if min.abs > current_error
    end
  end

  def backward_propagate(correct_values)
    correct_matrix = format_to_matrix(correct_values)

    (layer_count - 1).times do |index|
      if index == 0
        delta[-1] = (activations.last - correct_matrix).hadamard(sigmoid_prime_matrix(z_values.last))
        biases[-1] -= learning_rate * delta[-1]
        weights[-1] -= learning_rate * (activations[-2].transpose * delta[-1])
      else
        backwards_layer_index = -(index + 1)
        delta[backwards_layer_index] =
          (delta[backwards_layer_index + 1] * weights[backwards_layer_index + 1].transpose)
          .hadamard(sigmoid_prime_matrix(z_values[backwards_layer_index]))

        biases[backwards_layer_index] -= learning_rate * delta[backwards_layer_index]
        weights[backwards_layer_index] -= learning_rate * (activations[backwards_layer_index - 1].transpose * delta[backwards_layer_index])
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
end
