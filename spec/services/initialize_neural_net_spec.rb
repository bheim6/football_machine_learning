require 'rails_helper'

describe 'Neural net' do
  context 'initializes' do
    it 'with correct number of layers and nodes' do
      nn  = NeuralNet.new(3,4,1)

      expect(nn.weights.count).to eq(3)
      expect(nn.weights.first).to eq(Matrix.zero(1))
      expect(nn.weights[1].row_count).to eq(3)
      expect(nn.weights[1].column_count).to eq(4)
      expect(nn.weights.last.row_count).to eq(4)
      expect(nn.weights.last.column_count).to eq(1)

      expect(nn.biases.count).to eq(3)
      expect(nn.biases.first).to eq(Matrix.zero(1))
      expect(nn.biases[1].row_count).to eq(1)
      expect(nn.biases[1].column_count).to eq(4)
      expect(nn.biases.last.row_count).to eq(1)
      expect(nn.biases.last.column_count).to eq(1)

      expect(nn.activations.count).to eq(3)
      expect(nn.activations.first.row_count).to eq(1)
      expect(nn.activations.first.column_count).to eq(3)
      expect(nn.activations[1].row_count).to eq(1)
      expect(nn.activations[1].column_count).to eq(4)
      expect(nn.activations.last.row_count).to eq(1)
      expect(nn.activations.last.column_count).to eq(1)
    end

    it 'with random weights and biases for all the nodes' do
      # nn = NeuralNet.new(2,1)
      #
      # allow_any_instance_of(NeuralNet).to receive(:gaussian_random).and_return(0.5)
      #
      # expected_matrix = Matrix.build(2, 1) { 0.5 }
      #
      # expect(nn.weights.last).to eq(expected_matrix)
    end
  end
end
