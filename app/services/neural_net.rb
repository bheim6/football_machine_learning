class NeuralNet
  attr_reader :weights,
              :biases,
              :activations,
              :layer_count,
              :layer_sizes

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

  private
    attr_reader :gen

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
    end
end
