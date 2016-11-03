class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.string :current_team

      t.timestamps
    end
  end
end
