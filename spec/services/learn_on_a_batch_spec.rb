require 'rails_helper'

describe 'Neural net learns' do
  it 'given multiple sets of data simultainiously' do
    nn = NeuralNet.new(4,3,2)

    correct_values = [[0.3,0.2],[0.6,0.5],[0.5,0.1]]
    nn.initial_activation = [[0.4,0.3,0.2,0.1],[0.7,0.6,0.5,0.4],[0.3,0.8,0.9,0.12]]

    nn.forward_propagate
    nn.backward_propagate(correct_values)
    nn.forward_propagate

    expect(nn.results.row_count).to eq(3)
    expect(nn.results.column_count).to eq(2)
  end
end
