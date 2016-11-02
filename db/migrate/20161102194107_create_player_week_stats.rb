class CreatePlayerWeekStats < ActiveRecord::Migration[5.0]
  def change
    create_table :player_week_stats do |t|
      t.references :player, foreign_key: true
      t.references :season_week, foreign_key: true
      t.integer :rush_yds, default: 0
      t.integer :rush_att, default: 0
      t.integer :rush_td, default: 0
      t.integer :rec_yds, default: 0
      t.integer :rec_made, default: 0
      t.integer :rec_td, default: 0
      t.integer :pass_att, default: 0
      t.integer :pass_comp, default: 0
      t.integer :pass_yds, default: 0
      t.integer :pass_td, default: 0
      t.integer :pass_int, default: 0
      t.integer :sacked, default: 0

      t.timestamps
    end
  end
end
