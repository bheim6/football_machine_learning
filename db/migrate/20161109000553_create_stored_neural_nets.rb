class CreateStoredNeuralNets < ActiveRecord::Migration[5.0]
  def change
    create_table :stored_neural_nets do |t|
      t.decimal :first_weights, array: true, default: []
      t.decimal :hidden_weights, array: true, default: []
      t.decimal :last_weights, array: true, default: []
      t.decimal :first_biases, array: true, default: []
      t.decimal :hidden_biases, array: true, default: []
      t.decimal :last_biases, array: true, default: []
      t.integer :layer_sizes, array: true, default: []

      t.timestamps
    end
  end
end
