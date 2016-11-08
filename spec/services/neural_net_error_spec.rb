require 'rails_helper'

describe 'Neural Net learns' do
  it 'within a given error' do
    nn = NeuralNet.new(6,5,4)
    error = 0.0001
    correct_data = [0.2,0.7,0.9,0.3]
    correct_matrix  = Matrix[[0.2,0.7,0.9,0.3]]
    nn.initial_activation = [0.6, 0.2, 0.3, 0.4, 0.5, 0.9]
    nn.learn_within_error(correct_data,error)
    expect((nn.results - correct_matrix).max).to be_between(-error, error).exclusive
    expect((nn.results - correct_matrix).min).to be_between(-error, error).exclusive
  end
end
