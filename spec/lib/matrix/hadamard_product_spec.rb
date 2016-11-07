require 'rails_helper'



describe 'hadamard product' do
  context 'itself' do
    it 'returns squared matrix' do
      result_matrix = Matrix[[1,4], [9,16]]
      start_matrix = Matrix[[1,2], [3,4]]

      expect(start_matrix.hadamard(start_matrix)).to eq(result_matrix)
    end
  end

  context 'row vector' do
    it 'returns row vector result' do
      start_matrix_1 = Matrix[[2,3,4]]
      start_matrix_2 = Matrix[[4,5,6]]
      result_matrix = Matrix[[8,15,24]]

      expect(start_matrix_1.hadamard(start_matrix_2)).to eq(result_matrix)
      expect(start_matrix_2.hadamard(start_matrix_1)).to eq(result_matrix)
    end
  end

  context 'column vector' do
    it 'returns a column vector result' do
      start_matrix_1 = Matrix[[2], [3], [4]]
      start_matrix_2 = Matrix[[4], [5], [6]]
      result_matrix = Matrix[[8], [15], [24]]

      expect(start_matrix_1.hadamard(start_matrix_2)).to eq(result_matrix)
      expect(start_matrix_2.hadamard(start_matrix_1)).to eq(result_matrix)
    end
  end

  context 'arbitrary matrix' do
    it 'returns a result matrix of the same size as start matrices' do
      start_matrix_1 = Matrix[[2,3,4], [2,3,4]]
      start_matrix_2 = Matrix[[4,5,6], [4,5,6]]
      result_matrix = Matrix[[8,15,24], [8,15,24]]

      expect(start_matrix_1.hadamard(start_matrix_2)).to eq(result_matrix)
      expect(start_matrix_2.hadamard(start_matrix_1)).to eq(result_matrix)
    end
  end
end
