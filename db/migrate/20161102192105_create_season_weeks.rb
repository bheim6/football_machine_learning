class CreateSeasonWeeks < ActiveRecord::Migration[5.0]
  def change
    create_table :season_weeks do |t|
      t.integer :week
      t.integer :season

      t.timestamps
    end
  end
end
