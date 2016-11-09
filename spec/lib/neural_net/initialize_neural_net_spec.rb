require 'rails_helper'

describe 'Neural net initializes' do
  before(:all) do
    @nn  = NeuralNet.new(3,4,1)
  end

  context 'weights' do
    it 'with correct number of layers and nodes' do
      expect(@nn.weights.count).to eq(3)
      expect(@nn.weights.first).to eq(Matrix.zero(1))
      expect(@nn.weights[1].row_count).to eq(3)
      expect(@nn.weights[1].column_count).to eq(4)
      expect(@nn.weights.last.row_count).to eq(4)
      expect(@nn.weights.last.column_count).to eq(1)
    end
  end

  context 'biases' do
    it 'with correct number of layer and nodes' do
      expect(@nn.biases.count).to eq(3)
      expect(@nn.biases.first).to eq(Matrix.zero(1))
      expect(@nn.biases[1].row_count).to eq(1)
      expect(@nn.biases[1].column_count).to eq(4)
      expect(@nn.biases.last.row_count).to eq(1)
      expect(@nn.biases.last.column_count).to eq(1)
    end
  end

  context 'activations' do
    it 'with correct number of layers and nodes' do
      expect(@nn.activations.count).to eq(3)
      expect(@nn.activations.first.row_count).to eq(1)
      expect(@nn.activations.first.column_count).to eq(3)
      expect(@nn.activations[1].row_count).to eq(1)
      expect(@nn.activations[1].column_count).to eq(4)
      expect(@nn.activations.last.row_count).to eq(1)
      expect(@nn.activations.last.column_count).to eq(1)
    end

    it 'have values set' do
      @nn.initial_activation = [0.2, 0.4, 0.8]

      expected_matrix = Matrix[[0.2, 0.4, 0.8]]

      expect(@nn.activations.first).to eq(expected_matrix)
    end

    it 'has many sets of values' do
      @nn.initial_activation = [0.2, 0.4, 0.8], [0.1, 0.4, 0.5]

      expected_matrix = Matrix[[0.2, 0.4, 0.8], [0.1, 0.4, 0.5]]
      expect(@nn.activations.first).to eq(expected_matrix)
    end
  end

  xit 'with random weights and biases for all the nodes' do
    # nn = NeuralNet.new(2,1)
    #
    # allow_any_instance_of(NeuralNet).to receive(:gaussian_random).and_return(0.5)
    #
    # expected_matrix = Matrix.build(2, 1) { 0.5 }
    #
    # expect(nn.weights.last).to eq(expected_matrix)
  end
end
