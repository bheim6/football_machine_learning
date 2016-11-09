class CreateWeekPredictions < ActiveRecord::Migration[5.0]
  def change
    create_table :week_predictions do |t|
      t.decimal :fantasy_score
      t.references :player, foreign_key: true
      t.references :season_week, foreign_key: true

      t.timestamps
    end
  end
end
