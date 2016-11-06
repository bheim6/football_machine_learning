class NeuralNet
  attr_reader :activations,
              :layer_count,
              :layer_sizes

  attr_accessor :weights,
                :biases

  def initialize(*layer_sizes)
    @layer_sizes = layer_sizes
    @layer_count = layer_sizes.count
    @weights = Array.new(layer_count)
    @biases = Array.new(layer_count)
    @activations = Array.new(layer_count)
    @gen = Rubystats::NormalDistribution.new(0.5, 0.15)
    set_initial_values
  end

  def gaussian_random
    gen.rng
  end

  def initial_activation=(initial_values)
    unless initial_values.first.class == Array
      batch_size = 1
      activations[0] = Matrix[initial_values]
    else
      batch_size = initial_values.count
      activations[0] = Matrix.rows(initial_values)
    end
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
      # activations[layer] = sigmoid(activations[layer - 1] * weights[layer])
      # require "pry"; binding.pry
      if layer > 0
        z_values[layer] = activations[layer - 1] * weights[layer] + biases[layer]
        activations[layer] = sigmoid_matrix(z_values[layer])
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
      end
      @z_values = activations
    end

    def sigmoid_matrix(matrix)
      matrix.map { |element| sigmoid(element) }
    end

    def sigmoid(value)
      1 / (1 + Math.exp(-1 * value))
    end
end
