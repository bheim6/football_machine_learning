class CreateStoredNeuralNets < ActiveRecord::Migration[5.0]
  def change
    create_table :stored_neural_nets do |t|
      t.decimal :weights, array: true, default: []
      t.decimal :biases, array: true, default: []
      t.integer :layer_sizes, array: true, default: []

      t.timestamps
    end
  end
end
